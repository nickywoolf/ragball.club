defmodule Ragball.Repo.Migrations.AddGamesTable do
  use Ecto.Migration

  def change do
    create table(:games) do
      add(:location, :text, null: false)

      timestamps()
    end
  end

  def down do
    drop(table(:games))
  end
end
