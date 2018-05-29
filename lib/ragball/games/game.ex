defmodule Ragball.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:id, :location, :club_id, :creator_id]}

  schema "games" do
    field(:location, :string)

    belongs_to(:club, Ragball.Clubs.Club)
    belongs_to(:creator, Ragball.Users.User)

    timestamps()
  end

  def create_changeset(game, attrs \\ %{}) do
    game
    |> cast(attrs, [:location])
    |> validate_required([:location])
  end
end
