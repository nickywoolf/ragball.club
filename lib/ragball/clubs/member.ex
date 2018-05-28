defmodule Ragball.Clubs.Member do
  use Ecto.Schema
  import Ecto.Changeset

  schema "club_members" do
    field(:role, :string)

    belongs_to(:club, Ragball.Clubs.Club)
    belongs_to(:member, Ragball.Users.User)

    timestamps()
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:role, :club_id, :member_id])
  end
end
