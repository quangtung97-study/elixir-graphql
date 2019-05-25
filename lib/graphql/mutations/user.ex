defmodule Graphql.Mutations.User do
  alias Graphql.{Repo, User}

  def create_user(args) do
    args = Map.put(args, :password_confirmation, args[:password])

    User.changeset(args)
    |> Repo.insert()
  end
end
