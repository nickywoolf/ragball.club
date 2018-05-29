defmodule Ragball.TestFactories do
  alias Ragball.Clubs
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
      location: "Test Location",
      start_at: DateTime.utc_now()
    }
  end

  def create_user(user_params \\ %{}) do
    valid_user_params()
    |> Map.merge(user_params)
    |> Users.create_user()
  end

  def create_club(user, club_params \\ %{}) do
    club_params = Map.merge(valid_club_params(), club_params)
    Clubs.create_club(user, club_params)
  end

  def create_user_and_club(user_params \\ %{}, club_params \\ %{}) do
    {:ok, user} = create_user(user_params)
    create_club(user, club_params)
  end

  defp random_string do
    8
    |> :crypto.strong_rand_bytes()
    |> Base.encode16()
    |> String.downcase()
  end
end
