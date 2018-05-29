defmodule RagballWeb.API.GameControllerTest do
  use RagballWeb.ConnCase

  describe "POST /api/games given valid params as authenticated user" do
    setup %{conn: conn} do
      {:ok, user} = create_user()

      game_params =
        valid_game_params()
        |> Map.put(:location, "Irving Park")

      conn =
        conn
        |> assign(:current_user, user)
        |> post("/api/games", %{game: game_params})

      {:ok, %{conn: conn, user: user, game_params: game_params}}
    end

    test "creates a new game", %{conn: conn} do
      assert %{"game" => %{"location" => "Irving Park"}} = json_response(conn, 201)
    end
  end
end
