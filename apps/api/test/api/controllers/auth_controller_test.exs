defmodule Herps.API.AuthControllerTest do
  use Herps.API.ConnCase

  alias Herps.Core.Account.UserService

  # Google auth
  @ueberauth_auth %{credentials: %{token: "fdsnoafhnoofh08h38h"},
                    info: %{email: "user@example.com", first_name: "John", last_name: "Doe"},
                    provider: :google}

  test "redirects user to Google for authentication", %{conn: conn} do
    conn = get(conn, "/auth/google?scope=email%20profile")
    assert redirected_to(conn, 302)
  end
  test "creates user from Google information", %{conn: conn} do
      conn
      |> assign(:ueberauth_auth, @ueberauth_auth)
      |> get("/auth/google/callback")

      users = UserRepo.get_all()
      assert Enum.count(users) == 1
  end

end
