defmodule RestApiWeb.TeamController do
  use RestApiWeb, :controller

  alias RestApi.Admin
  alias RestApi.Admin.Team

  action_fallback RestApiWeb.FallbackController

  def index(conn, _params) do
    teams = Admin.list_teams()
    render(conn, :index, teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    with {:ok, %Team{} = team} <- Admin.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/teams/#{team}")
      |> render(:show, team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Admin.get_team!(id)
    render(conn, :show, team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Admin.get_team!(id)

    with {:ok, %Team{} = team} <- Admin.update_team(team, team_params) do
      render(conn, :show, team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Admin.get_team!(id)

    with {:ok, %Team{}} <- Admin.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
