defmodule RagballWeb.SessionControllerTest do
  use RagballWeb.ConnCase
  alias RagballWeb.Auth

  @credentials %{email: "test@example.com", password: "SECRET"}

  test "GET /sign-in displays sign in form to guests", %{conn: conn} do
    refute Auth.user(conn)

    conn = get(conn, "/sign-in")

    assert html_response(conn, 200) =~ "Sign in"
  end

  test "GET /sign-in redirects signed in user", %{conn: conn} do
    {:ok, %{user: user, club: _club}} = create_user_and_club()

    conn =
      conn
      |> assign(:current_user, user)
      |> get("/sign-in")

    assert redirected_to(conn, 302)
  end

  describe "POST /sign-in given valid credentials" do
    setup %{conn: conn} do
      {:ok, %{user: user, club: _club}} = create_user_and_club(@credentials)
      conn = post(conn, "/sign-in", %{session: @credentials})

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
      conn = post(conn, "/sign-in", %{session: @credentials})

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
        |> post("/sign-in", %{
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
