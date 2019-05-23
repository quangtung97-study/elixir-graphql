defmodule GraphqlWeb.Resolvers.Post do
  alias Graphql.Queries

  def posts(_, args, _) do
    {:ok, Queries.Post.list_posts(args)}
  end

  def author(parent, _, _) do
    {:ok, Queries.Post.author(parent.id)}
  end
end
