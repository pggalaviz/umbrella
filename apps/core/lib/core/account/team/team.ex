defmodule Herps.Core.Account.Team do
  @moduledoc """
  The main %Team{} module.
  This type repesents organizations, businesses, non profits, etc.
  Must have an owner which is a %User{} type
  """
  use Herps.Core.Schema

  # Define Teams schema
  schema "team" do
    field :owner, :binary_id
    field :name,  :string
    field :users, :integer
    field :email, :string

    # Relations
    has_one :account, Herps.Core.Account
    has_one :profile, Herps.Core.Account.Profile
  end
end
