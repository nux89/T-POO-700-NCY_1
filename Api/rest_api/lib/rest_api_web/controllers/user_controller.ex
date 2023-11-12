defmodule RestApiWeb.UserController do
  use RestApiWeb, :controller

  alias RestApi.Admin
  alias RestApi.Admin.User
  alias RestApiWeb.{Auth.Guardian,Auth.ErrorResponse}

  action_fallback RestApiWeb.FallbackController

  def index(conn, _params) do
    users = Admin.list_users()
    render(conn, :index, users: users)
  end

def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Admin.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user)  do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render("show.json", user: user, token: token)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Admin.get_user!(id)
    render(conn, :show, user: user)
  end

  def indexmails(conn, %{"email" => email, "username" => _user_params}) do
    user = Admin.get_user_by_email(email)
    render(conn, :show, user: user)
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Guardian.authenticate(email, password) do
      {:ok, user , token } ->
        conn
        |> put_status(:ok)
        |> render("show.json", %{user: user, token: token})
      {:error, :unauthorized} -> raise raise ErrorResponse.Unauthorized, message: "Email or Password incorrect."
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Admin.get_user!(id)

    with {:ok, %User{} = user} <- Admin.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Admin.get_user!(id)

    with {:ok, %User{}} <- Admin.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
