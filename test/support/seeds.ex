defmodule Graphql.Seeds do
  alias Graphql.{Repo, User}

  def insert_user(name) do
    User.changeset(%{name: name, password: "123456", password_confirmation: "123456"})
    |> Repo.insert!()
  end

  def insert_user(name, pwd) do
    User.changeset(%{name: name, password: pwd, password_confirmation: pwd})
    |> Repo.insert!()
  end

  def insert_post(user, title, body) do
    User.build_post(user, %{title: title, body: body})
    |> Repo.insert!()
  end

  def run do
    u1 = insert_user("tung")
    u2 = insert_user("ngan")
    insert_user("huyen")
    insert_user("dung")

    insert_post(u1, "ABCD", "body")
    insert_post(u2, "TUNG", "tung")
  end
end
