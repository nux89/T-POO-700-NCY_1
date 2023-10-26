defmodule RestApiWeb.ClockController do
  use RestApiWeb, :controller

  alias RestApi.Admin
  alias RestApi.Admin.Clock

  action_fallback RestApiWeb.FallbackController

  def index(conn, _params) do
    clocks = Admin.list_clocks()
    render(conn, :index, clocks: clocks)
  end

  def create(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- Admin.create_clock(Map.put(clock_params, "user_id", conn.params["id"])) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/clocks/#{clock.id}")
      |> render(:show, clock: clock)
    end
  end

  def show(conn, %{"user_id" => user_id}) do
    clock = Admin.get_clock_by_user_id(user_id)
    render(conn, :show, clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Admin.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Admin.update_clock(clock, clock_params) do
      render(conn, :show, clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Admin.get_clock!(id)

    with {:ok, %Clock{}} <- Admin.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
