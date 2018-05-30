defmodule RagballWeb.API.PublishedGameControllerTest do
  use RagballWeb.ConnCase
  alias Ragball.Games

  describe "POST /api/published-games with existing game id" do
    setup %{conn: conn} do
      {:ok, %{user: user, club: _club}} = create_user_and_club()
      {:ok, game} = create_game(user)

      conn =
        conn
        |> post("/api/published-games", %{published_game: %{id: game.id}})

      {:ok, %{conn: conn, game: game}}
    end

    test "publishes game", %{game: original_game} do
      refute original_game.published_at

      published_game = Games.get_game!(original_game.id)

      assert published_game.published_at
    end
  end
end
