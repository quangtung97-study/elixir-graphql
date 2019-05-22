defmodule Graphql.Queries.User do
  import Ecto.Query
  alias Graphql.{Repo, User}

  def list_users(filters) do
    filters
    |> Enum.reduce(User, fn
      {_, nil}, query ->
        query

      {:order, order}, query ->
        from u in query, order_by: {^order, :name}

      {:matching, name}, query ->
        from u in query, where: ilike(u.name, ^"%#{name}%")
    end)
    |> Repo.all()
  end
end
