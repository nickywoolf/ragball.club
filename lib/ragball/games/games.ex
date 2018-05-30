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

  def get_game!(id) do
    Repo.get!(Game, id)
  end

  def list_drafts do
    from(g in Game, where: is_nil(g.published_at)) |> Repo.all()
  end

  def list_upcoming do
    from(g in Game, where: not is_nil(g.published_at)) |> Repo.all()
  end

  def publish(id) do
    id
    |> Ragball.Games.get_game!()
    |> Game.publish_changeset()
    |> Repo.update()
  end
end
