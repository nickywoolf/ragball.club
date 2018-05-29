defmodule Ragball.TestFactories do
  alias Ragball.Users

  def valid_user_params do
    random = random_string()

    %{
      first_name: "Jane",
      last_name: "Doe",
      email: "jane#{random}@example.com",
      password: "secret"
    }
  end

  def valid_club_params do
    %{
      name: "Test Club"
    }
  end

  def valid_game_params do
    %{
      location: "Test Location"
    }
  end

  def create_user(user_params \\ %{}) do
    valid_user_params()
    |> Map.merge(user_params)
    |> Users.create_user()
  end

  defp random_string do
    8
    |> :crypto.strong_rand_bytes()
    |> Base.encode16()
    |> String.downcase()
  end
end
