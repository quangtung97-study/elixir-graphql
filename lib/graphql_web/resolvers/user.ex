defmodule GraphqlWeb.Resolvers.User do
  alias Graphql.Queries

  def users(_, args, _) do
    {:ok, Queries.User.list_users(args)}
  end
end
