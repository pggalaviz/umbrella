defmodule Herps.Core.Accounts.UserTest do
  use Herps.Core.DataCase

  alias Herps.Core.Account.User

  @valid_attrs %{email: "user@example.com", first_name: "John", last_name: "Doe", age: 25}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  # Test for User password
  test "User register changeset with valid password" do
    changeset = User.registration_changeset(%User{}, Map.put(@valid_attrs, :password, "secure_password"))
    assert changeset.valid?
  end
  test "User register changeset with invalid password" do
    changeset = User.registration_changeset(%User{}, Map.put(@valid_attrs, :password, "nope"))
    refute changeset.valid?
  end
end
