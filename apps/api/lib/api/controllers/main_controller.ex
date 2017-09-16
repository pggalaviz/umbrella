defmodule Herps.API.MainController do
  use Herps.API, :controller

  def index(conn, _params) do
    message = Herps.Core.core_status()
    render(conn, "index.json", [
      message: message
    ])
  end
end
