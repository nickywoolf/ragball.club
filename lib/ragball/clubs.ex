defmodule Ragball.Clubs do
  alias Ecto.Multi
  alias Ragball.Clubs.Club
  alias Ragball.Clubs.Member
  alias Ragball.Repo
  alias Ragball.Users

  def create_club(user, params) do
    params_with_associations = Map.put(params, :creator_id, user.id)
    changeset = Club.create_changeset(%Club{}, params_with_associations)

    Multi.new()
    |> Multi.insert(:club, changeset)
    |> Multi.run(:member, &create_owner(user, Map.get(&1, :club)))
    |> Multi.run(:user, &Users.set_current_club(user, Map.get(&1, :club)))
    |> Repo.transaction()
  end

  def add_member(user, club) do
    %Member{}
    |> Member.changeset(%{member_id: user.id, club_id: club.id, role: "MEMBER"})
    |> Repo.insert()
  end

  def create_owner(user, club) do
    %Member{}
    |> Member.changeset(%{member_id: user.id, club_id: club.id, role: "OWNER"})
    |> Repo.insert()
  end
end
