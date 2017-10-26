defmodule Herps.API.Auth.Guardian do
  @moduledoc """
  This is the main Guardian implementation to work with JWT authentication.
  """
  use Guardian, otp_app: :api
  alias Herps.Core.Account.UserService

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(claims) do
    case UserService.get_one(claims["sub"]) do
      nil ->
        {:error, :auth_error}
      user ->
        {:ok, user}
    end
  end
end
