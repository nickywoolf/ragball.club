defmodule Ragball.ClubsTest do
  use Ragball.DataCase
  alias Ragball.Clubs

  describe "create_club/2 given user and valid params" do
    setup do
      club_name = "Portland"
      {:ok, user} = create_user()

      params =
        valid_club_params()
        |> Map.put(:name, club_name)

      club =
        case Clubs.create_club(user, params) do
          {:ok, club} ->
            Ragball.Repo.preload(club, :creator)
        end

      %{creator: user, club: club, club_name: club_name}
    end

    test "creates new club", %{club: club, club_name: club_name} do
      assert club.name == club_name
    end

    test "creates new club with creator", %{club: club, creator: creator} do
      assert club.creator == creator
    end
  end
end
