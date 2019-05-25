defmodule GraphqlWeb.Resolvers.User do
  alias Graphql.Queries
  alias Graphql.Mutations

  def users(_, args, _) do
    {:ok, Queries.User.list_users(args)}
  end

  def create(_, args, _) do
    with {:ok, user} <- Mutations.User.create_user(args) do
      {:ok, user}
    else
      {:error, cs} -> {:error, Enum.map(cs.errors, &translate_error/1)}
    end
  end

  defp translate_error({key, error}) do
    key = Gettext.gettext(GraphqlWeb.Gettext, to_string(key))
    key = String.capitalize(key)
    "#{key} #{GraphqlWeb.ErrorHelpers.translate_error(error)}"
  end
end
