defmodule Ragball.Users do
  alias Ragball.Repo
  alias Ragball.Users.User

  def create_user(params) do
    %User{}
    |> User.create_changeset(params)
    |> Repo.insert()
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end
end
