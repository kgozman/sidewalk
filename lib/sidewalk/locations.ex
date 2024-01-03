defmodule Sidewalk.Locations do
  @moduledoc """
  The Location context.
  """

  import Ecto.Query, warn: false
  alias Sidewalk.Repo

  alias Sidewalk.Location.Map
  alias Sidewalk.Locations.Location

  @doc """
  Returns the list of locations.

  ## Examples

      iex> list_locations()
      [%Map{}, ...]


  """
  
  def get_location_query do
    from l in Location, select: l
  end

  def list_locations do
    query = from l in Location, select: l
    stream = Sidewalk.Repo.stream(query)
    Location |> Ecto.Query.stream()
  end

  @doc """
  Gets a single map.

  Raises `Ecto.NoResultsError` if the Map does not exist.

  ## Examples

      iex> get_map!(123)
      %Map{}

      iex> get_map!(456)
      ** (Ecto.NoResultsError)

  """
  def get_map!(id), do: Repo.get!(Map, id)

  @doc """
  Creates a map.

  ## Examples

      iex> create_map(%{field: value})
      {:ok, %Map{}}

      iex> create_map(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_map(attrs \\ %{}) do
    %Map{}
    |> Map.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a map.

  ## Examples

      iex> update_map(map, %{field: new_value})
      {:ok, %Map{}}

      iex> update_map(map, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_map(%Map{} = map, attrs) do
    map
    |> Map.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a map.

  ## Examples

      iex> delete_map(map)
      {:ok, %Map{}}

      iex> delete_map(map)
      {:error, %Ecto.Changeset{}}

  """
  def delete_map(%Map{} = map) do
    Repo.delete(map)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking map changes.

  ## Examples

      iex> change_map(map)
      %Ecto.Changeset{data: %Map{}}

  """
  def change_map(%Map{} = map, attrs \\ %{}) do
    Map.changeset(map, attrs)
  end
end
