defmodule Ragball.Clubs.ClubUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "club_users" do
    field(:role, :string)
    belongs_to(:club, Ragball.Clubs.Club)
    belongs_to(:club_user, Ragball.Users.User)

    timestamps()
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:role, :club_id, :club_user_id])
  end
end
