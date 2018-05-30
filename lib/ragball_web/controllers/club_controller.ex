defmodule RagballWeb.ClubController do
  use RagballWeb, :controller

  def show(conn, %{"id" => slug}) do
    club = Ragball.Clubs.get_club_by_slug(slug)
    render(conn, "show.html", club: club)
  end
end
