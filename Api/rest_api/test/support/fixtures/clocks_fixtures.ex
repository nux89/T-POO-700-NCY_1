defmodule RestApi.ClocksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestApi.Clocks` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2023-10-23 13:42:00]
      })
      |> RestApi.Clocks.create_clock()

    clock
  end
end
