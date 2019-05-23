defmodule Graphql.Queries.Post do
  alias Graphql.{Repo, User, Post}
  import Ecto.Query

  def list_posts(_) do
    Repo.all(Post)
  end

  def posts_of(author_id) do
    query =
      from p in Post,
        where: p.author_id == ^author_id

    Repo.all(query)
  end

  def author(post_id) do
    query =
      from u in User,
        join: p in assoc(u, :posts),
        where: p.id == ^post_id

    Repo.one(query)
  end
end
