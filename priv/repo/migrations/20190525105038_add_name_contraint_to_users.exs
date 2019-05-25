defmodule Graphql.Repo.Migrations.AddNameContraintToUsers do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:name])
  end
end
