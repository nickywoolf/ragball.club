defmodule Ragball.Users.User do
  use Ecto.Schema

  import Ecto.Changeset
  import RagballWeb.Gettext

  schema "users" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:password_hash, :string)

    field(:password, :string, virtual: true)

    timestamps()
  end

  def create_changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password])
    |> validate_required([:first_name, :email, :password])
    |> validate_format(:email, email_format(), message: dgettext("errors", "is invalid"))
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  def email_format do
    ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/
  end

  def put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset),
    do: put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))

  def put_password_hash(changeset), do: changeset
end
