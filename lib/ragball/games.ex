defmodule Ragball.Games do
  alias Ragball.Repo
  alias Ragball.Clubs
  alias Ragball.Games.Game

  def create_game(user, params \\ %{}) do
    user
    |> Clubs.current_club()
    |> Ecto.build_assoc(:games)
    |> Game.create_changeset(params)
    |> Ecto.Changeset.put_assoc(:creator, user)
    |> Repo.insert()
  end
end
