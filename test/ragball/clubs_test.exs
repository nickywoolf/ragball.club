defmodule Ragball.ClubsTest do
  use Ragball.DataCase
  alias Ragball.Clubs

  setup do
    {:ok, user} = create_user()

    %{user: user}
  end

  describe "create_club/2 given user and valid params" do
    setup %{user: user} do
      params =
        valid_club_params()
        |> Map.put(:name, "Portland")

      {:ok, %{club: club, user: user}} = Clubs.create_club(user, params)

      %{club: club, user: user}
    end

    test "creates new club", %{club: club} do
      assert club.name == "Portland"
    end

    test "creates new club with creator", %{club: club, user: user} do
      assert club.creator_id == user.id
    end

    test "sets user's current club to new club", %{club: club, user: user} do
      assert club.id == user.current_club_id
    end

    test "adds user as member", %{club: club, user: user} do
      club = Repo.preload(club, :members)

      assert Enum.any?(club.members, &(&1.member_id == user.id))
    end

    test "adds user as OWNER", %{club: club, user: user} do
      club = Repo.preload(club, :members)

      assert club.members
             |> Enum.filter(&(&1.role == "OWNER"))
             |> Enum.any?(&(&1.member_id == user.id))
    end
  end

  test "create_club/2 requires a club name", %{user: user} do
    params =
      valid_club_params()
      |> Map.delete(:name)

    {:error, :club, %Ecto.Changeset{errors: errors}, _} = Clubs.create_club(user, params)

    assert [name: {"can't be blank", _}] = errors
  end
end
