defmodule RestApiWeb.Router do
  
  use RestApiWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RestApiWeb do
    pipe_through :api
    resources "/teams", TeamController, except: [:new, :edit]
    post "users", UserController, :create
    put "users/:id", UserController, :update
    delete "users/:id", UserController, :delete
    get "users", UserController, :index
    post "/users/sign_in", UserController, :sign_in
    get "users/:id", UserController, :show
    get "users/:email/:username", UserController, :indexmails
    post "clocks/:id" , ClockController, :create
    get "clocks/:user_id", ClockController, :show
    get "workingtimes", WorkingtimeController, :index
    get "workingtimes/:userId/:id", WorkingtimeController, :show
    post "workingtimes/:id", WorkingtimeController, :create
    put "workingtimes/:id", WorkingtimeController, :update
    delete "workingtimes/:id", WorkingtimeController, :delete
    post "team", TeamController, :create
    get "team/:id", TeamController, :show
    put "team/:id", TeamController, :update
    delete "team/:id", TeamController, :delete
    get "team", TeamController, :index

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
