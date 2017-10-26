defmodule Herps.Core.Account do
  use Herps.Core.Schema

  # Define Accounts schema
  schema "account" do
    field :team?,      :boolean, default: false
    field :plan_level, :integer, default: 1

    # Relations
    belongs_to :user, Herps.Core.Account.User
    belongs_to :team, Herps.Core.Account.Team
  end
end
