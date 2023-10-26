defmodule RestApiWeb.Router do
  use RestApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :accepts, ["json"]
    plug CORSPlug,
    origins: "*",
    methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"]
    plug CORSICA,
    origins: "http://localhost:5173/",
    methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"]
  end

  scope "/api", RestApiWeb do
    pipe_through :api
    post "users", UserController, :create
    put "users/:id", UserController, :update
    delete "users/:id", UserController, :delete
    get "users/:id", UserController, :show
    get "users/:email/:username", UserController, :indexmail
    post "clocks/:id" , ClockController, :create
    get "clocks/:user_id", ClockController, :show
    get "workingtimes", WorkingtimeController, :index
    get "workingtimes/:userId/:id", WorkingtimeController, :show
    post "workingtimes/:id", WorkingtimeController, :create
    put "workingtimes/:id", WorkingtimeController, :update
    delete "workingtimes/:id", WorkingtimeController, :delete

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
