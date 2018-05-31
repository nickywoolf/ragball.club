defmodule Ragball.Clubs.Club do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clubs" do
    field(:name, :string)
    field(:slug, :string)

    belongs_to(:creator, Ragball.Users.User)
    has_many(:members, Ragball.Clubs.Member)
    has_many(:games, Ragball.Games.Game)

    timestamps()
  end

  defimpl Phoenix.Param, for: Ragball.Clubs.Club do
    def to_param(%{slug: slug}), do: slug
  end

  def create_changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:name, :slug, :creator_id])
    |> put_slug(attrs)
    |> validate_required([:name, :slug])
  end

  defp put_slug(club, %{slug: slug}) do
    slug =
      slug
      |> String.downcase()
      |> String.replace(" ", "-")

    put_change(club, :slug, slug)
  end

  defp put_slug(club, %{name: name}) do
    put_slug(club, %{slug: name})
  end
end
