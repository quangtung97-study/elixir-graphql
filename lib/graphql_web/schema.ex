defmodule GraphqlWeb.Schema do
  use Absinthe.Schema

  enum :sort_order do
    value(:asc)
    value(:desc)
  end

  scalar :date do
    parse(fn input ->
      case Date.from_iso8601(input.value) do
        {:ok, date} -> {:ok, date}
        _ -> :error
      end
    end)

    serialize(fn date ->
      DateTime.to_iso8601(date)
    end)
  end

  import_types(__MODULE__.UserTypes)
  import_types(__MODULE__.PostTypes)

  query do
    import_fields(:user_queries)
    import_fields(:post_queries)
  end

  mutation do
    import_fields(:user_mutations)
  end
end
