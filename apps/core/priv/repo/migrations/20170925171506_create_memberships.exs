defmodule Herps.Core.Repo.Migrations.CreateMemberships do
  use Ecto.Migration

  def change do
    create table(:memberships, primary_key: false) do
      add :id,      :uuid, primary_key: true
      add :role,    :integer, default: 0, null: false
      add :user_id, references(:users, type: :uuid), null: false
      add :team_id, references(:teams, type: :uuid), null: false

      # Time
      timestamps()
    end

    create index(:memberships, [:user_id])
    create index(:memberships, [:team_id])
  end
end
