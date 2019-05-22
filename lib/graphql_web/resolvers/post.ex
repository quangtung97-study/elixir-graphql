defmodule GraphqlWeb.Resolvers.Post do
  alias Graphql.Queries

  def posts(_, args, _) do
    {:ok, Queries.Post.list_posts(args)}
  end
end
