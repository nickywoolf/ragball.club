defmodule Ragball.Games do
  import Ecto.Query, only: [from: 2]

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

  def list_drafts do
    from(g in Game, where: is_nil(g.published_at)) |> Repo.all()
  end
end
