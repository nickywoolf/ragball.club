defmodule RagballWeb.API.GameControllerTest do
  use RagballWeb.ConnCase
  alias Ragball.Games

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

      %{"game" => game} = json_response(conn, 201)

      {:ok, %{conn: conn, user: user, club: club, game: game, game_params: game_params}}
    end

    test "creates a new game", %{game: game} do
      assert game["location"] == "Irving Park"
    end

    test "creates game for club", %{game: game, club: club} do
      assert game["club_id"] == club.id
    end

    test "creates game with user as creator", %{game: game, user: user} do
      assert game["creator_id"] == user.id
    end

    test "creates game without published_at date", %{game: game} do
      assert Map.has_key?(game, "published_at")
      refute game["published_at"]
    end

    test "creates game in draft state", %{game: game} do
      assert Games.list_drafts() |> Enum.any?(&(&1.id == game["id"]))
    end
  end
end
