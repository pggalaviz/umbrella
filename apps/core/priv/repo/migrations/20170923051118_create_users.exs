defmodule Herps.Core.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    # The ci text extensions allows to search case-sensitive fields without
    # using "lowercase" or similar aproaches.
    execute "CREATE EXTENSION IF NOT EXISTS citext;"

    create table(:users, primary_key: false) do
      add :id,                    :uuid, primary_key: true
      add :email,                 :citext, null: false
      add :first_name,            :string, null: false
      add :last_name,             :string, null: false
      add :age,                   :integer, default: 0, null: false
      add :phone_number,          :string
      add :auth_provider,         :string
      add :auth_token,            :string
      add :auth_token_expires_at, :naive_datetime
      add :last_log_in_at,        :naive_datetime
      add :joined_at,             :naive_datetime
      add :verified,              :boolean, default: false, null: false
      add :contributor,           :boolean, default: false, null: false
      add :admin,                 :boolean, default: false, null: false

      # Time
      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
