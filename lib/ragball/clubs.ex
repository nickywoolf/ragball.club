defmodule Ragball.Clubs do
  alias Ragball.Repo
  alias Ragball.Clubs.Club

  def create_club(user, params) do
    params_with_associations =
      params
      |> Map.put(:creator_id, user.id)

    %Club{}
    |> Club.create_changeset(params_with_associations)
    |> Repo.insert()
  end
end
