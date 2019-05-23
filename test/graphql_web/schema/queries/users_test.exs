defmodule GraphqlWeb.Schema.Queries.UsersTest do
  use GraphqlWeb.ConnCase, async: true

  setup do
    Graphql.Seeds.run()
    :ok
  end

  @query """
  {
    users {
      name
      posts {
        title
      }
    }
  }
  """
  test "return user's names and posts", %{conn: conn} do
    conn = get conn, "/api", query: @query

    assert json_response(conn, 200) == %{
             "data" => %{
               "users" => [
                 %{
                   "name" => "dung",
                   "posts" => []
                 },
                 %{
                   "name" => "huyen",
                   "posts" => []
                 },
                 %{
                   "name" => "ngan",
                   "posts" => [
                     %{"title" => "TUNG"}
                   ]
                 },
                 %{
                   "name" => "tung",
                   "posts" => [
                     %{"title" => "ABCD"}
                   ]
                 }
               ]
             }
           }
  end

  @query """
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
    conn = get conn, "/api", query: @query

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

  @query """
  query ($term: String) {
    users(matching: $term) {
      name
    }
  }
  """
  @variables %{"term" => "ung"}
  test "users and matching", %{conn: conn} do
    conn = get conn, "/api", query: @query, variables: @variables

    assert json_response(conn, 200) == %{
             "data" => %{
               "users" => [
                 %{"name" => "dung"},
                 %{"name" => "tung"}
               ]
             }
           }
  end

  @query """
  query ($order: SortOrder!) {
    users(order: $order) {
      name
    }
  }
  """
  @variables %{"order" => "DESC"}
  test "users DESC order", %{conn: conn} do
    conn = get conn, "/api", query: @query, variables: @variables

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
end
