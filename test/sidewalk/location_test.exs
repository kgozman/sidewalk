defmodule Sidewalk.LocationTest do
  use Sidewalk.DataCase

  alias Sidewalk.Location

  describe "locations" do
    alias Sidewalk.Location.Map

    import Sidewalk.LocationFixtures

    @invalid_attrs %{}

    test "list_locations/0 returns all locations" do
      map = map_fixture()
      assert Location.list_locations() == [map]
    end

    test "get_map!/1 returns the map with given id" do
      map = map_fixture()
      assert Location.get_map!(map.id) == map
    end

    test "create_map/1 with valid data creates a map" do
      valid_attrs = %{}

      assert {:ok, %Map{} = map} = Location.create_map(valid_attrs)
    end

    test "create_map/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Location.create_map(@invalid_attrs)
    end

    test "update_map/2 with valid data updates the map" do
      map = map_fixture()
      update_attrs = %{}

      assert {:ok, %Map{} = map} = Location.update_map(map, update_attrs)
    end

    test "update_map/2 with invalid data returns error changeset" do
      map = map_fixture()
      assert {:error, %Ecto.Changeset{}} = Location.update_map(map, @invalid_attrs)
      assert map == Location.get_map!(map.id)
    end

    test "delete_map/1 deletes the map" do
      map = map_fixture()
      assert {:ok, %Map{}} = Location.delete_map(map)
      assert_raise Ecto.NoResultsError, fn -> Location.get_map!(map.id) end
    end

    test "change_map/1 returns a map changeset" do
      map = map_fixture()
      assert %Ecto.Changeset{} = Location.change_map(map)
    end
  end
end
