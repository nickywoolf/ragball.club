defmodule RagballWeb.Plugs.RedirectIfAuthenticated do
  import Phoenix.Controller, only: [redirect: 2]

  alias RagballWeb.Router.Helpers, as: Routes
  alias Ragball.Clubs
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
    club = Clubs.get_current_club(user)
    path = Routes.game_path(conn, :index, club)

    conn
    |> redirect(to: path)
    |> Plug.Conn.halt()
  end
end
