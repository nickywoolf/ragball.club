defmodule RagballWeb.GameView do
  use RagballWeb, :view

  def title("index.html", %{club: club}) do
    "#{club.name} Games - Ragball"
  end
end
