defmodule Ragball.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS citext")

    create table(:users) do
      add(:first_name, :text, null: false)
      add(:last_name, :text)
      add(:email, :citext, null: false)
      add(:password_hash, :text, null: false)
      add(:current_club_id, :integer, null: true)

      timestamps()
    end

    create(unique_index(:users, [:email]))
  end

  def down do
    drop(index(:users, [:email]))
    drop(table(:users))
  end
end
