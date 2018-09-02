defmodule PersonalSiteWeb.Router do
  use PersonalSiteWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PersonalSiteWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/posts/rss.xml", PostController, :rss
    resources "/posts", PostController, only: [:index, :create, :show, :update, :delete]
    resources "/feedback", PostController, only: [:index, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", PersonalSiteWeb do
  #   pipe_through :api
  # end
end
