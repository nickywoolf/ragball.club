defmodule Ragball.Games do
  alias Ragball.Repo
  alias Ragball.Games.Game

  def create_game(params \\ %{}) do
    %Game{}
    |> Game.create_changeset(params)
    |> Repo.insert()
  end
end
