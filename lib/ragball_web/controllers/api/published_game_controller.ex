defmodule RagballWeb.API.PublishedGameController do
  use RagballWeb, :controller

  def create(conn, %{"published_game" => %{"id" => id}}) do
    id
    |> Ragball.Games.publish()
    |> create_response(conn)
  end

  defp create_response({:ok, game}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", game: game)
  end
end
