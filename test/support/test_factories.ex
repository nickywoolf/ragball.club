defmodule Ragball.TestFactories do
  alias Ragball.Users

  def valid_user_params do
    %{
      first_name: "Jane",
      last_name: "Doe",
      email: "jane@example.com"
    }
  end

  def valid_club_params do
    %{
      name: "Test Club"
    }
  end

  def create_user(user_params \\ %{}) do
    valid_user_params()
    |> Map.merge(user_params)
    |> Users.create_user()
  end
end
