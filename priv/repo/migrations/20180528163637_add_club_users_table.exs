defmodule Ragball.Repo.Migrations.AddClubUsersTable do
  use Ecto.Migration

  def change do
    execute("CREATE TYPE club_user_role AS ENUM ('OWNER', 'ADMIN', 'MEMBER')")

    create table(:club_users) do
      add(:club_id, references(:clubs))
      add(:club_user_id, references(:users))
      add(:role, :club_user_role, null: false, default: "MEMBER")

      timestamps()
    end

    create(unique_index(:club_users, [:club_id, :club_user_id]))
  end

  def down do
    drop(index(:club_users, [:club_id, :club_user_id]))
    drop(table(:club_users))
  end
end
