defmodule RagballWeb.ClubControllerTest do
  use RagballWeb.ConnCase

  describe "GET /c/:club_slug/games as signed in user" do
    setup %{conn: conn} do
      {:ok, %{club: club, user: user}} = create_user_and_club()

      games =
        [
          "Irving Park",
          "Woodlawn Park",
          "Wilshire Park"
        ]
        |> Enum.map(&create_published_game(&1, user))

      conn =
        conn
        |> assign(:current_user, user)
        |> get(club_path(conn, :show, club))

      {:ok, %{conn: conn, club: club, user: user, games: games}}
    end

    test "displays upcoming games", %{conn: conn, games: games} do
      games |> Enum.each(&assert html_response(conn, 200) =~ &1.location)
    end
  end

  defp create_published_game(location, user) do
    {:ok, game} = create_game(user, %{location: location})
    Ragball.Games.publish(game.id)
    game
  end
end
