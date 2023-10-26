defmodule RestApiWeb.ClockJSON do
  alias RestApi.Admin.Clock

  @doc """
  Renders a list of clocks.
  """
  def index(%{clocks: clocks}) do
    %{data: for(clock <- clocks, do: data(clock))}
  end

  @doc """
  Renders a single clock.
  """
  def show(%{clock: clock}) do
    %{data: data(clock)}
  end

  defp data(%Clock{} = clock) do
    %{
      id: clock.id,
      status: clock.status,
      time: clock.time,
      user_id: clock.user_id
    }
  end

  defp data(nil) do
    %{}
  end


end
