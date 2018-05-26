defmodule Ragball.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS citext")

    create table(:users) do
      add(:first_name, :text)
      add(:last_name, :text)
      add(:email, :citext)

      timestamps()
    end
  end

  def down do
    drop(table(:users))
  end
end
