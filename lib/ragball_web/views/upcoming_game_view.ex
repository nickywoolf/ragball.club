defmodule RagballWeb.UpcomingGameView do
  use RagballWeb, :view

  def title("index.html", %{club: club}) do
    "#{club.name} Games - Ragball"
  end

  def games(_club) do
    Ragball.Games.list_upcoming()
  end
end
