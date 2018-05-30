defmodule RagballWeb.SessionController do
  use RagballWeb, :controller

  alias Ragball.Clubs
  alias RagballWeb.Auth

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    conn
    |> Auth.sign_in_with_credentials(email, password)
    |> create_response()
  end

  defp create_response({:ok, conn}) do
    club =
      conn
      |> Auth.user()
      |> Clubs.get_current_club()

    conn
    |> put_flash(:info, "Welcome back")
    |> redirect(to: upcoming_game_path(conn, :index, club))
  end

  defp create_response({:error, _reason, conn}) do
    conn
    |> put_flash(:error, "Oops, those credentials are not correct")
    |> render("new.html")
  end
end
