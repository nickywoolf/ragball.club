defmodule RagballWeb.UpcomingGameController do
  use RagballWeb, :controller

  def index(conn, %{"slug" => slug}) do
    club = Ragball.Clubs.get_club_by_slug(slug)
    render(conn, "index.html", club: club)
  end
end
