defmodule Ragball.Clubs.Club do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ragball.Users.User

  schema "clubs" do
    field(:name, :string)

    belongs_to(:creator, User)

    timestamps()
  end

  def create_changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:name, :creator_id])
  end
end
