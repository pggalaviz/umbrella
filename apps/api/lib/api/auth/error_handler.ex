defmodule Herps.API.Auth.ErrorHandler do
  import Plug.Conn

  def auth_error(conn, {_failure_type, reason}, _opts) do
    conn
    |> send_resp(401, Poison.encode!(%{code: 401, errors: %{details: reason}}))
    |> halt()
  end
end
