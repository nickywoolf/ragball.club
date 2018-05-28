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
    user = Users.get_user_by_email(email)

    cond do
      user && correct_password?(password, user) ->
        {:ok, sign_in(conn, user)}

      user ->
        {:error, :unauthorized, conn}

      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

  @doc """
  """
  def restore_user_from_session(conn, _opts \\ []) do
    user_id = get_session(conn, :user_id)

    cond do
      user = conn.assigns[:current_user] ->
        conn

      user = user_id && Users.get_user!(user_id) ->
        assign(conn, :current_user, user)

      true ->
        assign(conn, :current_user, nil)
    end
  end
end
