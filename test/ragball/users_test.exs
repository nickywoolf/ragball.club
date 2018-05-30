defmodule Ragball.UsersTest do
  use Ragball.DataCase
  alias Ragball.Users
  alias RagballWeb.Auth

  describe "create_user/1" do
    test "creates new user given valid params" do
      params =
        valid_user_params()
        |> Map.put(:first_name, "Nicky")

      {:ok, user} = Users.create_user(params)

      assert user.first_name == "Nicky"
    end

    test "requires an email address" do
      params =
        valid_user_params()
        |> Map.delete(:email)

      {:error, %Ecto.Changeset{errors: errors}} = Users.create_user(params)

      assert [email: {"can't be blank", _}] = errors
    end

    test "requires a valid email address" do
      params =
        valid_user_params()
        |> Map.put(:email, "invalid")

      {:error, %Ecto.Changeset{errors: errors}} = Users.create_user(params)

      assert [email: {"is invalid", _}] = errors
    end

    test "requires a unique email address" do
      params =
        valid_user_params()
        |> Map.put(:email, "jane@example.com")

      {:ok, _user} = Users.create_user(params)

      {:error, %Ecto.Changeset{errors: errors}} = Users.create_user(params)

      assert [email: {"has already been taken", _}] = errors
    end

    test "requires a password" do
      params =
        valid_user_params()
        |> Map.delete(:password)

      {:error, %Ecto.Changeset{errors: errors}} = Users.create_user(params)

      assert [password: {"can't be blank", _}] = errors
    end

    test "stores hashed version of password" do
      params =
        valid_user_params()
        |> Map.put(:password, "test-password")

      {:ok, user} = Users.create_user(params)

      assert Auth.correct_password?("test-password", user)
    end

    test "requires a first name" do
      params =
        valid_user_params()
        |> Map.delete(:first_name)

      {:error, %Ecto.Changeset{errors: errors}} = Users.create_user(params)

      assert [first_name: {"can't be blank", _}] = errors
    end

    test "doesn't require a last name" do
      params =
        valid_user_params()
        |> Map.delete(:last_name)

      assert {:ok, _user} = Users.create_user(params)
    end
  end
end
