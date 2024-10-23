defmodule DzirWeb.Router do
  use DzirWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DzirWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Hypa.Plug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DzirWeb do
    pipe_through :browser

    get "/",          PageController, :home

    get "/about",     PageController, :about
    get "/մասին",     PageController, :about

    get "/websites",  PageController, :websites

    get "/next",      PageController, :next
    get "/յաջորդ",    PageController, :next
    get "/prev",      PageController, :prev
    get "/նախորդ",    PageController, :prev
    get "/rand",      PageController, :rand
    get "/պատահական", PageController, :rand

  end

  # Other scopes may use custom stacks.
  # scope "/api", DzirWeb do
  #   pipe_through :api
  # end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:dzir, :dev_routes) do

    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
