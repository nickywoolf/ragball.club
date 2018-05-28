defmodule Ragball.Clubs.Club do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clubs" do
    field(:name, :string)

    belongs_to(:creator, Ragball.Users.User)
    has_many(:members, Ragball.Clubs.Member)

    timestamps()
  end

  def create_changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:name, :creator_id])
    |> validate_required([:name])
  end
end
