defmodule GraphqlWeb.PageControllerTest do
  use GraphqlWeb.ConnCase
  import GraphqlWeb.Gettext

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ gettext("Welcome to %{name}!", name: "Phoenix")
  end
end
