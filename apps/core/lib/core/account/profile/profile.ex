defmodule Herps.Core.Account.Profile do
  use Herps.Core.Schema

  # Define Profiles schema
  schema "profiles" do
    field :team?,    :boolean, default: false
    field :username, :string
    field :name,     :string

    # Relations
    belongs_to :user, Herps.Core.Account.User
    belongs_to :team, Herps.Core.Account.Team
  end
end
