defmodule GraphqlWeb.Schema.Mutations.UsersTest do
  use GraphqlWeb.ConnCase, async: true

  @query """
  mutation($name: String!, $password: String!) {
    createUser(name: $name, password: $password) {
      name
    }
  }
  """
  @variables %{"name" => "New user", "password" => "123456"}
  test "insert user successfully", %{conn: conn} do
    conn = post conn, "/api", query: @query, variables: @variables

    assert json_response(conn, 200) == %{
             "data" => %{
               "createUser" => %{
                 "name" => @variables["name"]
               }
             }
           }
  end
end
