defmodule RagballWeb.Plugs.AssignUserFromSession do
  alias Ragball.Users
  alias Ragball.Users.User

  def init(opts) do
    opts
  end

  def call(conn, _opts \\ []) do
    assign_current_user(conn, Plug.Conn.get_session(conn, :user_id))
  end

  defp assign_current_user(%{assigns: %{current_user: _user}} = conn, _user_id) do
    conn
  end

  defp assign_current_user(conn, nil) do
    Plug.Conn.assign(conn, :current_user, nil)
  end

  defp assign_current_user(conn, user_id) do
    case Users.get_user!(user_id) do
      %User{} = user -> Plug.Conn.assign(conn, :current_user, user)
      _ -> assign_current_user(conn, nil)
    end
  end
end
