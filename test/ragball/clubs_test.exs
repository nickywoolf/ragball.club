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
        |> Map.delete(:slug)

      {:ok, %{club: club, user: user}} = Clubs.create_club(user, params)

      %{club: club, user: user}
    end

    test "creates new club", %{club: club} do
      assert club.name == "Portland"
    end

    test "creates club with slug", %{club: club} do
      assert club.slug == "portland"
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

  describe "add_member/2 given user and club" do
    setup %{user: owner} do
      params =
        valid_club_params()
        |> Map.put(:name, "Portland")

      {:ok, %{club: club, user: owner}} = Clubs.create_club(owner, params)
      {:ok, member} = create_user()
      Clubs.add_member(member, club)
      club = Repo.preload(club, :members)

      %{club: club, member: member, owner: owner}
    end

    test "adds user as club member", %{club: club, member: member} do
      assert Enum.count(club.members) == 2
      assert Enum.any?(club.members, &(&1.member_id == member.id))
    end

    test "adds user with role MEMBER", %{club: club, member: member} do
      club_member =
        club.members
        |> Enum.filter(&(&1.member_id == member.id))
        |> Enum.at(0)

      assert club_member.member_id == member.id
    end
  end
end
