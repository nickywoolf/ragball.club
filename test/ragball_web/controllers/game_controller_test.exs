defmodule RagballWeb.GameControllerTest do
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
        |> get(game_path(conn, :index, club))

      {:ok, %{conn: conn, club: club, user: user, games: games}}
    end

    test "displays upcoming games", %{conn: conn, games: games} do
      games |> Enum.each(&assert html_response(conn, 200) =~ &1.location)
    end
  end

  @tag :only
  test "displays upcoming games for current club only", %{conn: conn} do
    other_club_params = %{name: "Other Club", slug: "other-club"}
    {:ok, %{club: _other_club, user: user}} = create_user_and_club(%{}, other_club_params)
    _other_game = create_published_game("Other Park", user)

    {:ok, %{club: club, user: user}} = create_club(user)

    _games =
      ["Irving Park", "Woodlawn Park", "Wilshire Park"]
      |> Enum.map(&create_published_game(&1, user))

    conn =
      conn
      |> assign(:current_user, user)
      |> get(game_path(conn, :index, club))

    body = html_response(conn, 200)

    assert body =~ "Irving Park"
    assert body =~ "Woodlawn Park"
    assert body =~ "Wilshire Park"
    refute body =~ "Other Park"
  end

  defp create_published_game(location, user) do
    {:ok, game} = create_game(user, %{location: location})
    Ragball.Games.publish(game.id)
    game
  end
end
