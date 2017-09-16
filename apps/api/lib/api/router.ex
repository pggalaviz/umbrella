defmodule Herps.API.Router do
  use Herps.API, :router

  # RESTful API pipeline
  pipeline :rest do
    plug :accepts, [:json]
  end

  scope "/", Herps.API do
    pipe_through :rest

    get "/", MainController, :index
  end
end
