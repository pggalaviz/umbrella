defmodule Herps.API.AuthView do
  use Herps.API, :view

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
