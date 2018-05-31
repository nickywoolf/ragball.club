defmodule RagballWeb.GameController do
  use RagballWeb, :controller

  def index(conn, %{"slug" => slug}) do
    club = Ragball.Clubs.get_club_by_slug(slug)

    games =
      conn
      |> RagballWeb.Auth.user()
      |> Ragball.Games.list_upcoming()

    render(conn, "index.html", club: club, games: games)
  end
end
