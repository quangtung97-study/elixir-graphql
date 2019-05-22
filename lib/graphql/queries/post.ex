defmodule Graphql.Queries.Post do
  alias Graphql.{Repo, Post}

  def list_posts(_) do
    Repo.all(Post)
  end
end
