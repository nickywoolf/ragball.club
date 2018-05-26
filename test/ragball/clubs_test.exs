defmodule Ragball.ClubsTest do
  use Ragball.DataCase
  alias Ragball.Clubs

  describe "create_club/2 given user and valid params" do
    setup do
      club_params = valid_club_params() |> Map.put(:name, "Portland")
      {:ok, user} = create_user()
      {:ok, club} = Clubs.create_club(user, club_params)
      club = Repo.preload(club, :creator)

      %{club: club, user: user}
    end

    test "creates new club", %{club: club} do
      assert club.name == "Portland"
    end

    test "creates new club with creator", %{club: club, user: user} do
      assert club.creator == user
    end
  end
end
