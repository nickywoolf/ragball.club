defmodule RagballWeb.Router do
  use RagballWeb, :router

  alias RagballWeb.Plugs.DenyGuest
  alias RagballWeb.Plugs.RedirectIfAuthenticated

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

  pipeline :browser_api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
    plug(:put_secure_browser_headers)
    plug(:assign_user_from_session)
    plug(DenyGuest, %{content_type: :json})
  end

  scope "/", RagballWeb do
    pipe_through(:browser)
    pipe_through(RedirectIfAuthenticated)

    get("/", PageController, :index)
    get("/sign-in", SessionController, :new)
    post("/sign-in", SessionController, :create)
  end

  scope "/", RagballWeb do
    pipe_through(:browser)

    resources("/c", ClubController, only: [:show])
  end

  scope "/api", RagballWeb.API do
    pipe_through(:browser_api)

    resources("/games", GameController, only: [:create])
    resources("/published-games", PublishedGameController, only: [:create])
  end
end
