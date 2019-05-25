defmodule Graphql.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Graphql.{User, Post, Contact}
  alias Bcrypt

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    has_many :posts, Post, foreign_key: :author_id
    has_many :contacts, Contact

    timestamps()
  end

  defp put_password_hash(%Ecto.Changeset{errors: []} = changeset) do
    password = get_change(changeset, :password)
    hash = Bcrypt.hash_pwd_salt(password)
    change(changeset, password_hash: hash)
  end

  defp put_password_hash(changeset), do: changeset

  def changeset(%User{} = user, params) do
    user
    |> cast(params, [:name, :password, :password_confirmation])
    |> validate_required([:name, :password, :password_confirmation])
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> put_password_hash()
    |> unique_constraint(:name)
  end

  def changeset(params) do
    changeset(%User{}, params)
  end

  def build_post(%User{} = user, params) do
    post = Ecto.build_assoc(user, :posts)
    Post.changeset(post, params)
  end

  def build_contact(%User{} = user, params) do
    contact = Ecto.build_assoc(user, :contacts)
    Contact.changeset(contact, params)
  end
end
