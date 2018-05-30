defmodule RagballWeb.Plugs.DenyGuest do
  def init(opts) do
    opts
  end

  def call(conn, %{content_type: :json}) do
    case RagballWeb.Plugs.Auth.user(conn) do
      %Ragball.Users.User{} ->
        conn

      nil ->
        conn
        |> Plug.Conn.put_status(:unauthorized)
        |> Phoenix.Controller.render(RagballWeb.ErrorView, "401.json", [])
        |> Plug.Conn.halt()
    end
  end
end
