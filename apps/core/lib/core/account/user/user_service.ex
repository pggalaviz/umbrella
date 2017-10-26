defmodule Herps.Core.Account.UserService do
  @moduledoc """
  This module is where all User related database modification occurs.
  This is the only module that should be accesed by any other app.
  """

  import Ecto.Query
  alias Ecto.Multi
  alias Ecto.Changeset
  alias Herps.Core.Repo
  alias Herps.Core.Account.User
  alias Herps.Messenger.Email.ConfirmAccount

  @expires_in 15

  # Changesets
  def changeset(params) do
    User.changeset(%User{}, params)
  end
  def registration_changeset(params) do
    User.registration_changeset(%User{}, params)
  end
  def ueberauth_changeset(params) do
    User.ueberauth_changeset(%User{}, params)
  end
  def auth_changeset(params) do
    User.auth_changeset(%User{}, params)
  end
  def log_in_changeset(params) do
    User.log_in_changeset(%User{}, params)
  end

  # Read actions
  @spec get_one(Ecto.UUID.type) :: nil | Ecto.Shema.t
  def get_one(id) do
    Repo.get(User, to_string(id))
  end

  @spec get_all :: [Ecto.Schema.t]
  def get_all do
    Repo.all(User)
  end

  @spec get_by_email(bitstring) :: nil | Ecto.Schema.t
  def get_by_email(email) do
    User
    |> where(email: ^email)
    |> Repo.one()
  end

  @doc """
  Sets user's session data on the changeset for the first time, the token will be sent via email,
  it will be deleted once the user logs in.
  """
  @spec set_auth_info(Ecto.Changeset.t, integer) :: {:ok, Ecto.Schema.t} | {:error, Ecto.Changeset.t}
  def set_auth_info(changeset, expires_in \\ @expires_in) do
    auth_token = SecureRandom.base64(32)
    expires_at = Timex.add(Timex.now, Timex.Duration.from_minutes(expires_in))
    changeset
    |> Changeset.put_change(:auth_token, auth_token)
    |> Changeset.put_change(:auth_token_expires_at, expires_at)
  end

  @doc """
  Refresh user's session data the token will be sent via email, it will be deleted once the user logs in.
  """
  @spec create_auth_info(Ecto.Schema.t, integer) :: {:ok, Ecto.Schema.t} | {:error, Ecto.Changeset.t}
  def refresh_auth_info(%User{} = user, expires_in \\ @expires_in) do
    auth_token = SecureRandom.base64(32)
    expires_at = Timex.add(Timex.now, Timex.Duration.from_minutes(expires_in))
    changeset = User.auth_changeset(user, %{auth_token: auth_token, auth_token_expires_at: expires_at})
    Repo.update(changeset)
  end

  @doc """
  Refresh user's session data the token will be sent via email, it will be deleted once the user logs in.
  """
  @spec reset_auth_info(Ecto.Schema.t, integer) :: {:ok, Ecto.Schema.t} | {:error, Ecto.Changeset.t}
  def reset_auth_info(%User{} = user, expires_in \\ @expires_in) do
    changeset = User.auth_changeset(user, %{auth_token: nil, auth_token_expires_at: nil})
    Repo.update(changeset)
  end

  @doc """
  User creation by OAuth2.
  Should create an account and a profile including the newly created user's id.
  Must return {:ok, user} or {:error, changeset}
  """
  @spec create_by_provider(Ecto.Changeset.t) :: {:ok, Ecto.Schema.t} | {:error, any}
  def create_by_provider(%Ecto.Changeset{valid?: false} = changeset), do: {:error, changeset}
  def create_by_provider(%Ecto.Changeset{valid?: true} = changeset) do
    Repo.insert(changeset)
  end

  @doc """
  This function adds a new user struct into an ETS table, after the users confirm
  their email, the struct will be saved to de DB.
  """
  def pre_register(%Ecto.Changeset{valid?: false} = changeset), do: {:error, changeset}
  def pre_register(%Ecto.Changeset{valid?: true} = changeset) do
    new_changeset = set_auth_info(changeset)
    {:ok, new_changeset}
  end

  def register(%Ecto.Changeset{valid?: false} = changeset), do: {:error, changeset}
  def register(%Ecto.Changeset{valid?: true} = changeset) do
  end

  def send_login_email(%User{} = user, host) do
    case create_auth_info(user) do
      {:ok, updated_user} ->
        code = User.encode_auth(updated_user)
        url = host <> "/login/" <> code
        ConfirmAccount.send(user, url)
        {:ok, updated_user}
      {:error, user} ->
        {:error, "Something went wrong, try again later"}
    end
  end

  def validate_token(token) do
    [email, auth_token] = User.decode_auth(token)
    user = Repo.get_by(User, email: email, auth_token: auth_token)
    if user && Timex.before?(Timex.now, user.auth_token_expires_at) do
      {:ok, user}
    else
      {:error, "has expired"}
    end
  end

end
