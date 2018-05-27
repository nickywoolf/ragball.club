defmodule RagballWeb.SessionController do
  use RagballWeb, :controller
  alias Ragball.Users.User
  alias RagballWeb.Plugs.Auth

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Ragball.Users.find_user_by_email(email) do
      %User{} = user ->
        case Auth.correct_password?(password, user) do
          true ->
            conn
            |> Auth.sign_in(user)
            |> redirect(to: "/")
        end
    end
  end
end
