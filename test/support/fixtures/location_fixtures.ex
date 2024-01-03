defmodule Sidewalk.LocationFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sidewalk.Location` context.
  """

  @doc """
  Generate a map.
  """
  def map_fixture(attrs \\ %{}) do
    {:ok, map} =
      attrs
      |> Enum.into(%{

      })
      |> Sidewalk.Location.create_map()

    map
  end
end
