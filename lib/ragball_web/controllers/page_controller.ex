defmodule RagballWeb.PageController do
  use RagballWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
