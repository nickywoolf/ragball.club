defmodule RagballWeb.SessionController do
  use RagballWeb, :controller
  alias RagballWeb.Plugs.Auth

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Auth.sign_in_with_credentials(conn, email, password) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back")
        |> redirect(to: "/")

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Oops, those credentials are not correct")
        |> render("new.html")
    end
  end
end
