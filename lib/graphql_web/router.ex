defmodule GraphqlWeb.Router do
  use GraphqlWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  scope "/", GraphqlWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: GraphqlWeb.Schema,
      interface: :simple

    forward "/", Absinthe.Plug, schema: GraphqlWeb.Schema
  end
end
