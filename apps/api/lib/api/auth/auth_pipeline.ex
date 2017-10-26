defmodule Herps.API.Auth.AuthPipeline do
  @moduledoc """
  This Pipeline searches for a JWT in the Authorization header, if found it will load
  the resource from it, a User in this case.
  """
  @claims %{typ: "access"}

  use Guardian.Plug.Pipeline, otp_app: :api,
                              module: Herps.API.Auth.Guardian,
                              error_handler: Herps.API.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader, claims: @claims, realm: "Bearer"
  plug Guardian.Plug.LoadResource, allow_blank: true
end
