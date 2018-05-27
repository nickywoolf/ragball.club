defmodule RagballWeb.Plugs.Auth do
  alias Ragball.Users.User

  def correct_password?(password, %User{password_hash: hash}) do
    Comeonin.Bcrypt.checkpw(password, hash)
  end

  def sign_in(conn, user) do
    conn
    |> Plug.Conn.put_session(:user_id, user.id)
    |> Plug.Conn.configure_session(renew: true)
  end
end
