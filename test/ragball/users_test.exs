defmodule Ragball.UsersTest do
  use Ragball.DataCase

  describe "create_user/1" do
    test "creates new user given valid params" do
      {:ok, user} =
        valid_user_params()
        |> Map.put(:first_name, "Nicky")
        |> Ragball.Users.create_user()

      assert user.first_name == "Nicky"
    end
  end
end
