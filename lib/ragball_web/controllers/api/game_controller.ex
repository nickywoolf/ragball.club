defmodule RagballWeb.API.GameController do
  use RagballWeb, :controller

  alias Ragball.Games
  alias RagballWeb.Plugs.Auth

  def create(conn, %{"game" => game_params}) do
    conn
    |> Auth.user()
    |> Games.create_game(game_params)
    |> create_response(conn)
  end

  def create_response({:ok, game}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", game: game)
  end

  def create_response({:error, changeset}, conn) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(RagballWeb.ErrorView, "422.json", changeset: changeset)
  end
end
