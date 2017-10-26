defmodule Herps.Core.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams, primary_key: false) do
      add :id,          :uuid, primary_key: true
      add :owner,       :uuid
      add :name,        :string
      add :description, :text
      add :users,       :integer
      add :email,       :string

      # Time
      timestamps()
    end

  end
end
