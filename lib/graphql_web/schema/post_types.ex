defmodule GraphqlWeb.Schema.PostTypes do
  use Absinthe.Schema.Notation
  alias GraphqlWeb.Resolvers

  object :post do
    field :id, :id
    field :title, :string
    field :body, :string
    field :author_id, :id

    field :author, :user do
      resolve(&Resolvers.Post.author/3)
    end

    field :published_at, :date
    field :updated_at, :date
    field :inserted_at, :date
  end

  object :post_queries do
    @desc "list of all posts of all users"
    field :posts, list_of(:post) do
      resolve(&Resolvers.Post.posts/3)
    end
  end
end
