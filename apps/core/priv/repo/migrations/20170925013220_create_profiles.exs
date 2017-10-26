defmodule Herps.Core.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add :id,        :uuid, primary_key: true
      add :username,  :citext, null: false
      # Relations
      add :user_id, references(:users, type: :uuid, on_delete: :delete_all)
      add :team_id, references(:teams, type: :uuid, on_delete: :delete_all)
      # ---
      add :team?,     :boolean, default: false, null: false
      add :name,      :string, null: false
      add :bio,       :text
      add :twitter,   :citext
      add :facebook,  :citext
      add :youtube,   :citext
      add :instagram, :citext
      add :followers, :integer, default: 0, null: false
      add :following, :integer, default: 0, null: false
      add :rating,    :integer
      add :image_url, :string
      add :city,      :string
      add :country,   :string
      add :geojson,   :map
      add :joined_at, :naive_datetime, null: false
      # Time
      timestamps()
    end

    create unique_index(:profiles, [:username])
    create unique_index(:profiles, [:user_id])
    create unique_index(:profiles, [:team_id])
  end

end
