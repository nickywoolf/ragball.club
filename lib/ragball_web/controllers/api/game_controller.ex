defmodule RagballWeb.API.GameController do
  use RagballWeb, :controller

  def create(conn, %{"game" => game_params}) do
    case Ragball.Games.create_game(game_params) do
      {:ok, game} ->
        conn
        |> put_status(:created)
        |> render("create.json", game: game)
    end
  end
end
