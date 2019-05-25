defmodule GraphqlWeb.UserTest do
  use Graphql.DataCase
  alias Graphql.User

  test "correct error messages" do
    params = %{
      "name" => "",
      "password" => "123",
      "password_confirmation" => "1222"
    }

    cs = User.changeset(params)

    assert length(cs.errors) == 3

    assert [{_, opts1}] = Keyword.get_values(cs.errors, :password_confirmation)
    assert [{_, opts2}] = Keyword.get_values(cs.errors, :password)
    assert [{_, opts3}] = Keyword.get_values(cs.errors, :name)

    assert opts1 == [validation: :confirmation]

    assert {:count, 6} in opts2
    assert {:validation, :length} in opts2
    assert {:kind, :min} in opts2

    assert {:validation, :required} in opts3
  end
end
