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

      club =
        case Clubs.create_club(user, params) do
          {:ok, club} ->
            Repo.preload(club, :creator)
        end

      %{club: club, user: user}
    end

    test "creates new club", %{club: club} do
      assert club.name == "Portland"
    end

    test "creates new club with creator", %{club: club, user: user} do
      assert club.creator == user
    end
  end

  test "create_club/2 requires a club name", %{user: user} do
    params =
      valid_club_params()
      |> Map.delete(:name)

    {:error, %Ecto.Changeset{errors: errors}} = Clubs.create_club(user, params)

    assert [name: {"can't be blank", _}] = errors
  end
end
