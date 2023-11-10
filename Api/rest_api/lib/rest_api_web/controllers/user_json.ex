defmodule RestApiWeb.UserJSON do
  alias RestApi.Admin.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  def show(nil) do
    %{data: nil}
  end


  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
      password: user.password,
      team: user.team
    }
  end

  def showbymail(%{user: user}) do
    %{data: data(user)}
  end
end
