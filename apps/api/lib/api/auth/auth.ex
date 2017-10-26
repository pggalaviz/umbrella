defmodule Herps.API.Auth do
  import Plug.Conn
  alias Herps.API.Auth.Guardian

  # Generate a JWT and send it back to the client.
  def generate_token(user) do
    {:ok, jwt, _} = Guardian.encode_and_sign(user)
    {:ok, jwt}
  end

  # Log out and revoke the JWT
  def log_out(conn, _params) do
    jwt = Guardian.Plug.current_token(conn)
    Guardian.revoke(jwt)
    response = %{
      status: 204,
      message: "Successfuly logged out! Please remove the JWT from the Authorization header"
    }
    conn
    |> send_resp(204, Poison.encode!(response))
  end
end
