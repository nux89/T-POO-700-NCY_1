defmodule RestApiWeb.ClockControllerTest do
  use RestApiWeb.ConnCase

  import RestApi.AdminFixtures

  alias RestApi.Admin.Clock

  @create_attrs %{
    status: true,
    time: ~N[2023-10-24 12:09:00],
    user_id: "7488a646-e31f-11e4-aace-600308960662"
  }
  @update_attrs %{
    status: false,
    time: ~N[2023-10-25 12:09:00],
    user_id: "7488a646-e31f-11e4-aace-600308960668"
  }
  @invalid_attrs %{status: nil, time: nil, user_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end


  defp create_clock(_) do
    clock = clock_fixture()
    %{clock: clock}
  end
end
