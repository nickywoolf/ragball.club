defmodule RagballWeb.SessionControllerTest do
  use RagballWeb.ConnCase

  @sign_in_path session_path(RagballWeb.Endpoint, :create)
  @credentials %{email: "test@example.com", password: "SECRET"}

  test "GET /sign_in displays sign in form", %{conn: conn} do
    conn = get(conn, session_path(conn, :new))

    assert html_response(conn, 200) =~ "Sign in"
  end

  describe "POST /sign_in given valid credentials" do
    setup %{conn: conn} do
      {:ok, user} = create_user(@credentials)
      conn = post(conn, @sign_in_path, %{session: @credentials})

      {:ok, %{conn: conn, user: user}}
    end

    test "creates new session", %{conn: conn, user: user} do
      assert get_session(conn, :user_id) == user.id
    end

    test "assigns current user", %{conn: conn, user: user} do
      assert conn.assigns.current_user.id == user.id
    end

    test "creates session that remains for multiple requests", %{conn: conn, user: user} do
      conn =
        conn
        |> recycle()
        |> get("/")

      assert get_session(conn, :user_id) == user.id
      assert conn.assigns.current_user.id == user.id
    end

    test "redirects to SOMEWHERE", %{conn: conn} do
      assert redirected_to(conn) == "/"
    end

    test "displays welcome message", %{conn: conn} do
      assert get_flash(conn, :info) == "Welcome back"
    end
  end

  describe "POST /sign_in given unkown email address" do
    setup %{conn: conn} do
      conn = post(conn, @sign_in_path, %{session: @credentials})

      {:ok, %{conn: conn}}
    end

    test "something about an error", %{conn: conn} do
      assert get_flash(conn, :error) == "Oops, those credentials are not correct"
    end

    test "doesn't create a session", %{conn: conn} do
      refute get_session(conn, :user_id)
    end

    test "doesn't assign user", %{conn: conn} do
      refute conn.assigns.current_user
    end
  end

  describe "POST /sign_in given incorrect password" do
    setup %{conn: conn} do
      {:ok, _user} = create_user(@credentials)

      conn =
        conn
        |> post(@sign_in_path, %{
          session: %{
            email: @credentials.email,
            password: "INCORRECT"
          }
        })

      {:ok, %{conn: conn}}
    end

    test "something about an error", %{conn: conn} do
      assert get_flash(conn, :error) == "Oops, those credentials are not correct"
    end

    test "doesn't create a session", %{conn: conn} do
      refute get_session(conn, :user_id)
    end

    test "doesn't assign user", %{conn: conn} do
      refute conn.assigns.current_user
    end
  end
end
