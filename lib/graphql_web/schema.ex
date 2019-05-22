defmodule GraphqlWeb.Schema do
  use Absinthe.Schema
  alias GraphqlWeb.Resolvers

  enum :sort_order do
    value(:asc)
    value(:desc)
  end

  scalar :date do
    parse(fn input ->
      case Date.from_iso8601(input.value) do
        {:ok, date} -> {:ok, date}
        _ -> :error
      end
    end)

    serialize(fn date ->
      DateTime.to_iso8601(date)
    end)
  end

  object :post do
    field :id, :id
    field :title, :string
    field :body, :string
    field :author_id, :id
    field :published_at, :date
    field :updated_at, :date
    field :inserted_at, :date
  end

  object :user do
    field :id, :id
    field :name, :string

    field :posts, list_of(:post) do
      resolve(&Resolvers.Post.posts/3)
    end
  end

  query do
    @desc "list of all users"
    field :users, list_of(:user) do
      arg(:matching, :string)
      arg(:order, :sort_order)
      resolve(&Resolvers.User.users/3)
    end

    @desc "list of all posts of all users"
    field :posts, list_of(:post) do
      resolve(&Resolvers.Post.posts/3)
    end
  end
end
