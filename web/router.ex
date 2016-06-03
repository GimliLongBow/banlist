defmodule Banlist.Router do
  use Banlist.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Banlist.Auth, repo: Banlist.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Banlist do
    pipe_through :browser # Use the default browser stack

    resources "/users", UserController
    resources "/", BannedController

    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Banlist do
  #   pipe_through :api
  # end
end
