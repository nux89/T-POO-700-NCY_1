defmodule RestApiWeb.UserControllerTest do
  use RestApiWeb.ConnCase

  import RestApi.AdminFixtures

  alias RestApi.Admin.User

  @create_attrs %{
    email: "some email",
    name: "some name",
    password: "some password",
    role: "some role"
  }
  @update_attrs %{
    email: "some updated email",
    name: "some updated name",
    password: "some updated password",
    role: "some updated role"
  }
  @invalid_attrs %{email: nil, name: nil, password: nil, role: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

end
