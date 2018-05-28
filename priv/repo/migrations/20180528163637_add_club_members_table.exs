defmodule Ragball.Repo.Migrations.AddClubMembersTable do
  use Ecto.Migration

  def change do
    execute("CREATE TYPE club_member_role AS ENUM ('OWNER', 'ADMIN', 'MEMBER')")

    create table(:club_members) do
      add(:club_id, references(:clubs))
      add(:member_id, references(:users))
      add(:role, :club_member_role, null: false, default: "MEMBER")

      timestamps()
    end

    create(unique_index(:club_members, [:club_id, :member_id]))
  end

  def down do
    drop(index(:club_members, [:club_id, :member_id]))
    drop(table(:club_members))
  end
end
