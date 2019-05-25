defmodule GraphqlWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation
  alias GraphqlWeb.Resolvers

  object :user do
    field :id, :id
    field :name, :string

    field :posts, list_of(:post) do
      resolve(&Resolvers.Post.posts_of/3)
    end
  end

  object :user_queries do
    @desc "list of all users"
    field :users, list_of(:user) do
      arg(:matching, :string)
      arg(:order, type: :sort_order, default_value: :asc)
      resolve(&Resolvers.User.users/3)
    end
  end

  object :user_mutations do
    field :create_user, :user do
      arg(:name, :string)
      arg(:password, :string)
      resolve(&Resolvers.User.create/3)
    end
  end
end
