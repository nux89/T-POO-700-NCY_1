defmodule RestApiWeb.ClockJSON do
  alias RestApi.Clocks.Clock

  @doc """
  Renders a list of clock.
  """
  def index(%{clock: clock}) do
    %{data: for(clock <- clock, do: data(clock))}
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
      time: clock.time,
      status: clock.status
    }
  end
end
