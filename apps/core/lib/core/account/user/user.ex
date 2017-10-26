defmodule Herps.Core.Account.User do
  @moduledoc """
    Main %User{} model, with functions for registering and updating.
  """
  use Herps.Core.Schema

  # Define User schema
  schema "users" do
    field :email,                 :string
    field :first_name,            :string
    field :last_name,             :string
    field :age,                   :integer
    field :phone_number,          :string
    field :auth_provider,         :string, default: "email"
    field :auth_token,            :string
    field :auth_token_expires_at, DateTime
    field :last_log_in_at,        DateTime
    field :joined_at,             DateTime
    field :verified,              :boolean, default: false, null: false
    field :contributor,           :boolean, default: false, null: false
    field :admin,                 :boolean, default: false, null: false

    # Relations
    has_one :account, Herps.Core.Account
    has_one :profile, Herps.Core.Account.Profile

    # Time
    timestamps()
  end

  #Main changeset
  def changeset(%__MODULE__{} = user, params \\ %{}) do
    user
    |> cast(params, [:email, :first_name, :last_name, :age, :phone_number])
    |> validate_required([:email, :first_name, :last_name])
    |> validate_format(:email, ~r/.*@.*/)
    |> unique_constraint(:email)
  end

  # Registration changeset
  def registration_changeset(%__MODULE__{} = user, params \\ %{}) do
    user
    |> changeset(params)
    |> cast(params, [:verified, :auth_token, :auth_token_expires_at])
    |> validate_required([:verified])
  end

  # Ueberauth changeset
  def ueberauth_changeset(%__MODULE__{} = user, params \\ %{}) do
    user
    |> changeset(params)
    |> cast(params, [:auth_provider, :verified])
    |> validate_required([:verified])
  end

  def auth_changeset(%__MODULE__{} = user, params \\ %{}) do
    user
    |> cast(params, [:auth_token, :auth_token_expires_at])
  end

  def log_in_changeset(%__MODULE__{} = user) do
    user
    |> change(%{
      auth_token: nil,
      auth_token_expires_at: nil,
      last_log_in_at: Timex.now(),
      joined_at: (user.joined_at || Timex.now())
    })
  end

  def encode_auth(user) do
    Base.encode32("#{user.email}|#{user.auth_token}")
  end
  def decode_auth(code) do
    {:ok, decoded} = Base.decode32(code)
    String.split(decoded, "|")
  end

end
