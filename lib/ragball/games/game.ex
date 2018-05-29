defmodule Ragball.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:id, :location]}

  schema "games" do
    field(:location, :string)

    timestamps()
  end

  def create_changeset(game, attrs \\ %{}) do
    game
    |> cast(attrs, [:location])
  end
end
