defmodule RestApiWeb.WorkingtimeControllerTest do
  use RestApiWeb.ConnCase

  import RestApi.AdminFixtures

  alias RestApi.Admin.Workingtime

  @create_attrs %{
    end: ~N[2023-10-24 13:44:00],
    start: ~N[2023-10-24 13:44:00],
    user_id: "7488a646-e31f-11e4-aace-600308960662"
  }
  @update_attrs %{
    end: ~N[2023-10-25 13:44:00],
    start: ~N[2023-10-25 13:44:00],
    user_id: "7488a646-e31f-11e4-aace-600308960668"
  }
  @invalid_attrs %{end: nil, start: nil, user_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  defp create_workingtime(_) do
    workingtime = workingtime_fixture()
    %{workingtime: workingtime}
  end
end
