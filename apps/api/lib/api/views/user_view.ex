defmodule Herps.API.UserView do
  use Herps.API, :view

  def render("index.json", %{users: users}) do
    render_many(users, __MODULE__, "show.json")
  end

  def render("show.json", %{user: user}) do
    %{
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name
    }
  end

  def render("success.json", _assigns) do
    %{
      status: :ok,
      message: "Confirmation email sent, click the link on it to confirm account, it's valid for 15 minutes"
    }
  end

  def render("log_in.json", %{user: user, jwt: jwt}) do
    %{
      status: :ok,
      data: %{
        id: user.id,
        jwt: jwt
      },
      message: "Successfully logged in! Add the JWT to the Authorization header"
    }
  end
end
