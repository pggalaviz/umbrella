defmodule Herps.API.Auth.SecurePipeline do
  @moduledoc """
  This Pipeline ensures the JWT is authenticated, which means a user is logged in.
  """
  use Guardian.Plug.Pipeline, otp_app: :api,
                              module: Herps.API.Auth.Guardian,
                              error_handler: Herps.API.Auth.ErrorHandler

  plug Guardian.Plug.EnsureAuthenticated
end
