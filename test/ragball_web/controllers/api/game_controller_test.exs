defmodule RagballWeb.API.GameControllerTest do
  use RagballWeb.ConnCase

  describe "POST /api/games given valid params as authenticated user" do
    setup %{conn: conn} do
      {:ok, %{user: user, club: club}} = create_user_and_club()

      game_params =
        valid_game_params()
        |> Map.put(:location, "Irving Park")

      conn =
        conn
        |> assign(:current_user, user)
        |> post("/api/games", %{game: game_params})

      game = json_response(conn, 201)

      {:ok, %{conn: conn, user: user, club: club, game: game, game_params: game_params}}
    end

    test "creates a new game", %{game: game} do
      assert game["game"]["location"] == "Irving Park"
    end

    test "creates game for club", %{game: game, club: club} do
      assert game["game"]["club_id"] == club.id
    end
  end
end
