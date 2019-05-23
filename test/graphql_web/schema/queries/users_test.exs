defmodule GraphqlWeb.Schema.Queries.UsersTest do
  use GraphqlWeb.ConnCase, async: true

  setup do
    Graphql.Seeds.run()
    :ok
  end

  @users_query """
  {
    users {
      name
    }
  }
  """
  test "return user's names", %{conn: conn} do
    conn = get conn, "/api", query: @users_query

    assert json_response(conn, 200) == %{
             "data" => %{
               "users" => [
                 %{"name" => "tung"},
                 %{"name" => "ngan"},
                 %{"name" => "huyen"},
                 %{"name" => "dung"}
               ]
             }
           }
  end

  @posts_query """
  {
    posts {
      author {
        name
      }
      title
      body
    }
  }
  """
  test "return posts", %{conn: conn} do
    conn = get conn, "/api", query: @posts_query

    assert json_response(conn, 200) == %{
             "data" => %{
               "posts" => [
                 %{
                   "author" => %{
                     "name" => "tung"
                   },
                   "title" => "ABCD",
                   "body" => "body"
                 },
                 %{
                   "author" => %{
                     "name" => "ngan"
                   },
                   "title" => "TUNG",
                   "body" => "tung"
                 }
               ]
             }
           }
  end
end
