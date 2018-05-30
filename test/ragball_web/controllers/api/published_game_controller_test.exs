defmodule RagballWeb.API.PublishedGameControllerTest do
  use RagballWeb.ConnCase
  alias Ragball.Games

  describe "POST /api/published-games with existing game id" do
    setup %{conn: conn} do
      {:ok, %{user: user, club: _club}} = create_user_and_club()
      {:ok, game} = create_game(user)

      conn =
        conn
        |> assign(:current_user, user)
        |> post("/api/published-games", %{published_game: %{id: game.id}})

      {:ok, %{conn: conn, game: game}}
    end

    test "publishes game", %{game: original_game} do
      refute original_game.published_at

      fresh_game = Games.get_game!(original_game.id)

      assert fresh_game.published_at
    end

    test "response with created status", %{conn: conn} do
      assert json_response(conn, 201)
    end
  end

  test "POST /api/published-games required authenticated user", %{conn: conn} do
    {:ok, %{user: user, club: _club}} = create_user_and_club()
    {:ok, game} = create_game(user)

    conn =
      conn
      |> post("/api/published-games", %{published_game: %{id: game.id}})

    refute RagballWeb.Auth.user(conn)
    assert json_response(conn, 401) == %{"errors" => %{"auth" => ["Unauthorized"]}}
  end
end
