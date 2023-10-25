defmodule RestApiWeb.Router do
  use RestApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RestApiWeb do
    pipe_through :api
    get "/workingtimes/:userID", WorkingtimeController, :specificUser
    get "/workingtimes/:userID/:id", WorkingtimeController, :specificUser
    post "/workingtimes/:userID", WorkingtimeController, :specificUser
    put "/workingtimes/:id", WorkingtimeController, :specificUser
    delete "/workingtimes/:id", WorkingtimeController, :specificUser
    resources "/workingtimes", WorkingtimeController, except: [:new, :edit]
    resources "/clock", ClockController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:rest_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: RestApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
