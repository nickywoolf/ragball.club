defmodule RagballWeb.API.GameView do
  use RagballWeb, :view

  def render("create.json", %{game: game}) do
    %{game: game}
  end
end
