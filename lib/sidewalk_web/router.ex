defmodule SidewalkWeb.Router do
  use SidewalkWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {SidewalkWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", SidewalkWeb do
    pipe_through :browser
    get "/", PageController, :home

    live "/locations", MapLive.Index, :index
    live "/locations/new", MapLive.Index, :new
    live "/locations/:id/edit", MapLive.Index, :edit

    live "/locations/:id", MapLive.Show, :show
    live "/locations/:id/show/edit", MapLive.Show, :edit

    live "/maps", MapLive.Index, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SidewalkWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:sidewalk, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PowSidewalkWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
