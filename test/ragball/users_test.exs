defmodule Ragball.UsersTest do
  use Ragball.DataCase
  alias Ragball.Users

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

    test "requires a first name" do
      params =
        valid_user_params()
        |> Map.delete(:first_name)

      {:error, %Ecto.Changeset{errors: errors}} = Users.create_user(params)

      assert [first_name: {"can't be blank", _}] = errors
    end
  end
end
