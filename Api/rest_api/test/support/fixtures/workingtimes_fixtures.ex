defmodule RestApi.WorkingtimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestApi.Workingtimes` context.
  """

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime} =
      attrs
      |> Enum.into(%{
        end: ~N[2023-10-23 13:42:00],
        start: ~N[2023-10-23 13:42:00]
      })
      |> RestApi.Workingtimes.create_workingtime()

    workingtime
  end
end
