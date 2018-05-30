defmodule RagballWeb.ClubView do
  use RagballWeb, :view

  def title("show.html", %{club: club}) do
    "Ragball - #{club.name}"
  end

  def games(_club) do
    Ragball.Games.list_upcoming()
  end
end
