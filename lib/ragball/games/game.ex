defmodule Ragball.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {
    Poison.Encoder,
    only: [:id, :location, :start_at, :published_at, :club_id, :creator_id]
  }

  schema "games" do
    field(:location, :string)
    field(:start_at, :naive_datetime)
    field(:published_at, :naive_datetime)

    belongs_to(:club, Ragball.Clubs.Club)
    belongs_to(:creator, Ragball.Users.User)

    timestamps()
  end

  def create_changeset(game, attrs \\ %{}) do
    game
    |> cast(attrs, [:location, :published_at, :start_at])
    |> validate_required([:location, :start_at])
  end
end
