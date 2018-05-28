defmodule RagballWeb.Plugs.AuthTest do
  use ExUnit.Case, async: true

  alias Ragball.Users.User
  alias RagballWeb.Plugs.Auth

  describe "correct_password?/2" do
    test "true if password hashed matches hashed password" do
      password = "SECRET"
      user = %User{password_hash: Comeonin.Bcrypt.hashpwsalt(password)}

      assert Auth.correct_password?(password, user)
    end

    test "false if password hashed doesn't match hashed password" do
      user = %User{password_hash: Comeonin.Bcrypt.hashpwsalt("SECRET")}

      refute Auth.correct_password?("WRONG-PASSWORD", user)
    end
  end
end
