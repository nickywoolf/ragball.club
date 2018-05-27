defmodule RagballWeb.Plugs.Auth do
  alias Ragball.Users.User

  def correct_password?(password, %User{password_hash: hash}) do
    Comeonin.Bcrypt.checkpw(password, hash)
  end
end
