defmodule Herps.Core.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id,         :uuid, primary_key: true
      add :team?,      :boolean, default: false, null: false
      add :active?,    :boolean, default: false, null: false
      add :plan_level, :integer, default: 1

      # Relations
      add :user_id, references(:users, type: :uuid, on_delete: :nothing)
      add :team_id, references(:teams, type: :uuid, on_delete: :nothing)

      # Time
      timestamps()
    end

    create unique_index(:accounts, [:user_id])
    create unique_index(:accounts, [:team_id])
  end
end
