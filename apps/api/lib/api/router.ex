defmodule Herps.API.Router do
  use Herps.API, :router

  # RESTful API pipeline
  pipeline :rest do
    plug :accepts, [:json]
    plug Herps.API.Auth.AuthPipeline
  end
  # Required authentication
  pipeline :auth do
    plug Herps.API.Auth.SecurePipeline
  end

  scope "/", Herps.API do
    pipe_through :rest

    get "/", MainController, :index

    # Authentication with email/password
    post "/login", UserController, :log_in
    get "/login/:token", UserController, :log_in_with_token

    # Authentication with Ueberauth
    get "/auth/:provider", AuthController, :request
    get "/auth/:provider/callback", AuthController, :callback

    # Users
    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    post "/users", UserController, :create
  end

end
