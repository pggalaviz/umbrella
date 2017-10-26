defmodule Herps.API.AuthController do
  use Herps.API, :controller
  plug Ueberauth

  alias Herps.API.Auth
  alias Herps.Core.Account.UserService
  alias Herps.API.UserView

  @doc """
  Ueberauth callback for registering or signing an existent user via OAuth.
  """
  # If user accepts to send their data:
  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      phone_number: auth.info.phone,
      auth_provider: to_string(auth.provider),
      verified: true
    }
    changeset = UserService.ueberauth_changeset(user_params)
    create_or_log_in(conn, changeset)
  end
  # If user denies app to get data from OAuth provider:
  def callback(%{assigns: %{ueberauth_failure: _failure}} = conn, _params) do
    conn
    |> put_status(400)
    |> render(ErrorView, "400.json")
  end

  def log_in(user) do
    with {:ok, jwt} <- Auth.generate_token(user),
         {:ok, _user} <- UserService.reset_auth_info(user)
    do
      {:ok, jwt}
    end
  end

  ### Private functions for internal usage.

  defp create_or_log_in(conn, %{changes: %{email: email}} = changeset) do
    case UserService.get_by_email(email) do
      nil ->
        create_by_provider(conn, changeset)
      user ->
        log_in_by_provider(conn, user)
    end
  end

  defp create_by_provider(conn, changeset) do
    case UserService.create_by_provider(changeset) do
      {:ok, user} ->
        log_in_by_provider(conn, user)
      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(ChangesetView, "errors.json", changeset: changeset)
    end
  end

  defp log_in_by_provider(conn, user) do
    with {:ok, jwt} <- Auth.generate_token(user),
         {:ok, _user} <- UserService.reset_auth_info(user)
    do
      conn
      |> put_status(:ok)
      |> render("log_in.json", user: user, jwt: jwt)
    end
  end

end
