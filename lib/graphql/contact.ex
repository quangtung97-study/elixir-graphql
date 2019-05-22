defmodule Graphql.Contact do
  use Ecto.Schema
  import Ecto.Changeset
  alias Graphql.{User, Contact}

  schema "contacts" do
    field :type, :string
    field :value, :string
    belongs_to :user, User

    timestamps()
  end

  def changeset(%Contact{} = contact, params) do
    contact
    |> cast(params, [:type, :value, :user_id])
    |> validate_required([:type, :value, :user_id])
    |> validate_length(:type, max: 10)
    |> validate_length(:value, max: 100)
    |> assoc_constraint(:user)
  end

  def changeset(params) do
    changeset(%Contact{}, params)
  end
end
