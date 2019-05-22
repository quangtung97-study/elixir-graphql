defmodule Graphql.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Graphql.{User, Post}

  schema "posts" do
    field :title, :string
    field :body, :string
    field :published_at, :naive_datetime
    belongs_to :author, User

    timestamps()
  end

  def changeset(%Post{} = post, params) do
    post
    |> cast(params, [:title, :body, :published_at, :author_id])
    |> validate_required([:title, :body, :author_id])
    |> validate_length(:title, max: 50)
    |> validate_length(:body, max: 255)
    |> assoc_constraint(:author)
  end

  def changeset(params) do
    changeset(%Post{}, params)
  end
end
