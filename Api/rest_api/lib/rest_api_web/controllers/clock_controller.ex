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
    with {:ok, %Clock{} = clock} <- Admin.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/clocks/#{clock}")
      |> render(:show, clock: clock)
    end
  end

  def show(conn, %{"id" => id}) do
    clock = Admin.get_clock!(id)
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
