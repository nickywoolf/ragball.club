defmodule Ragball.Repo.Migrations.AddClubsTable do
  use Ecto.Migration

  def change do
    create table(:clubs) do
      add(:name, :text, null: false)

      add(:creator_id, references(:users), null: false)

      timestamps()
    end
  end

  def down do
    drop(table(:clubs))
  end
end
