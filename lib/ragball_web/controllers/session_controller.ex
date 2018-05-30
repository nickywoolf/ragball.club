defmodule RagballWeb.SessionController do
  use RagballWeb, :controller
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
    conn
    |> put_flash(:info, "Welcome back")
    |> redirect(to: "/")
  end

  defp create_response({:error, _reason, conn}) do
    conn
    |> put_flash(:error, "Oops, those credentials are not correct")
    |> render("new.html")
  end
end
