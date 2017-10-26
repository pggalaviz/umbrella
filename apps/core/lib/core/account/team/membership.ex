defmodule Herps.Core.Account.Organization.Membership do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  # Define Memberships schema
  schema "membership" do
    field :role, :integer, default: 0
    # Relations
    belongs_to :user, Herps.Core.Account.User
    belongs_to :team, Herps.Core.Account.Team
  end
end
