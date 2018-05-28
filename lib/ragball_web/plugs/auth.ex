defmodule RagballWeb.Plugs.Auth do
  @moduledoc """
  """

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Plug.Conn

  alias Ragball.Users.User
  alias Ragball.Users

  @doc """
  """
  def correct_password?(password, %User{password_hash: hash}) do
    checkpw(password, hash)
  end

  @doc """
  """
  def sign_in(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  @doc """
  """
  def sign_in_with_credentials(conn, email, password) do
    email
    |> Users.get_user_by_email()
    |> sign_in_user(password, conn)
  end

  @doc """
  """
  def assign_user_from_session(conn, _opts \\ []) do
    assign_current_user(conn, get_session(conn, :user_id))
  end

  defp sign_in_user(nil = _user, _password, conn) do
    dummy_checkpw()
    {:error, :not_found, conn}
  end

  defp sign_in_user(user, password, conn) do
    case correct_password?(password, user) do
      true -> {:ok, sign_in(conn, user)}
      _ -> {:error, :unauthorized, conn}
    end
  end

  defp assign_current_user(%{assigns: %{current_user: _user}} = conn, _user_id) do
    conn
  end

  defp assign_current_user(conn, nil) do
    assign(conn, :current_user, nil)
  end

  defp assign_current_user(conn, user_id) do
    case Users.get_user!(user_id) do
      %User{} = user -> assign(conn, :current_user, user)
      _ -> assign_current_user(conn, nil)
    end
  end
end
