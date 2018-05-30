defmodule RagballWeb.Plugs.RedirectIfAuthenticated do
  import Phoenix.Controller, only: [redirect: 2]

  alias RagballWeb.Router.Helpers, as: Routes
  alias Ragball.Users.User
  alias RagballWeb.Auth

  def init(opts) do
    opts
  end

  def call(conn, _opts \\ []) do
    case Auth.user(conn) do
      %User{} = user -> redirect_user(user, conn)
      nil -> conn
    end
  end

  defp redirect_user(user, conn) do
    path = Routes.upcoming_game_path(conn, :index, user.current_club_id)

    conn
    |> redirect(to: path)
    |> Plug.Conn.halt()
  end
end
