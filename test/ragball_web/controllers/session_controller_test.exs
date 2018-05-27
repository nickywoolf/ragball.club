defmodule RagballWeb.SessionControllerTest do
  use RagballWeb.ConnCase

  describe "POST /sign_in given valid credentials" do
    setup %{conn: conn} do
      sign_in_path = session_path(conn, :create)
      credentials = %{email: "test@example.com", password: "SECRET"}
      {:ok, user} = create_user(credentials)

      conn = post(conn, sign_in_path, %{session: credentials})

      %{conn: conn, user: user}
    end

    test "creates new session", %{conn: conn, user: user} do
      assert get_session(conn, :user_id) == user.id
    end
  end
end
