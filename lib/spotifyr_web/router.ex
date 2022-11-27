defmodule SpotifyrWeb.Router do
  use SpotifyrWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SpotifyrWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SpotifyrWeb do
    pipe_through :browser

    live "/", HomeLive
  end

  # Other scopes may use custom stacks.
  scope "/api", SpotifyrWeb do
    pipe_through :api
    get "/authorize", OAuthController, :authorize
    get "/authenticate", OAuthController, :authenticate
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:spotifyr, :dev_routes) do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
