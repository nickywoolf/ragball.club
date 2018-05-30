defmodule RagballWeb.API.PublishedGameView do
  use RagballWeb, :view

  def render("create.json", %{game: game}) do
    %{game: game}
  end
end
