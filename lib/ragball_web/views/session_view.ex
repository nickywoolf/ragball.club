defmodule RagballWeb.SessionView do
  use RagballWeb, :view

  def title("new.html", _) do
    "Ragball - Sign In"
  end

  def input_classes do
    "shadow-inner bg-grey-lighter border border-grey-light w-full p-2 rounded-sm mb-3"
  end
end
