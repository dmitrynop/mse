defmodule MseWeb.Router do
  use MseWeb, :router
  use ExAdmin.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  forward "/graphql", Absinthe.Plug, schema: Graph.Schema

  scope "/", MseWeb do
    pipe_through :browser # Use the default browser stack

    get "/*path", PageController, :index
  end
end
