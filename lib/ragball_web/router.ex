defmodule RagballWeb.Router do
  use RagballWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:assign_user_from_session)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", RagballWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/sign_in", SessionController, :new)
    post("/sign_in", SessionController, :create)
  end

  # Other scopes may use custom stacks.
  # scope "/api", RagballWeb do
  #   pipe_through :api
  # end
end
