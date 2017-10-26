defmodule Herps.API.UserController do
  use Herps.API, :controller

  alias Herps.API.AuthController
  alias Herps.Core.Account.UserService

  def index(conn, _params) do
    users = UserService.get_all()
    render(conn, "index.json", users: users)
  end
  def show(conn, %{"id" => id}) do
    user = UserService.get_one(id)
    render(conn, "show.json", user: user)
  end

  @doc """
  User registration POST /users
  """
  def create(conn, %{"user" => params}) do
    if UserService.get_by_email(params["email"]) do
      "Email already registered"
    else
      changeset = UserService.registration_changeset(params)
      case UserService.pre_register(changeset) do
        {:ok, _changeset} ->
          conn
          |> put_status(:ok)
          |> render("success.json")
        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(ChangesetView, "error.json", changeset: changeset)
      end
    end
  end

  def log_in(conn, %{"email" => email}) do
    case UserService.get_by_email(email) do
      nil ->
        conn
        |> put_status(:not_found)
        |> render(ErrorView, "404.json")
      user ->
        host = to_string(Herps.API.Router.Helpers.url(conn))
        case UserService.send_login_email(user, host) do
          {:ok, _user} ->
            conn
            |> put_status(:ok)
            |> render("success.json")
          {:error, _user} ->
            conn
            |> put_status(400)
            |> render(ErrorView, "400.json")
        end
    end
  end

  def log_in_with_token(conn, %{"token" => token}) do
    case UserService.validate_token(token) do
      {:ok, user} ->
        case AuthController.log_in(user) do
          {:ok, jwt} ->
            conn
            |> put_status(:ok)
            |> render("log_in.json", user: user, jwt: jwt)
          {:error, _reason} ->
            conn
            |> put_status(403)
            |> render(ErrorView, "400.json")
        end
      {:error, _reason} ->
        conn
        |> put_status(403)
        |> render(ErrorView, "400.json")
    end
  end

end
