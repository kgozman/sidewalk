defmodule SidewalkWeb.MapLiveTest do
  use SidewalkWeb.ConnCase

  import Phoenix.LiveViewTest
  import Sidewalk.LocationFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_map(_) do
    map = map_fixture()
    %{map: map}
  end

  describe "Index" do
    setup [:create_map]

    test "lists all locations", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/locations")

      assert html =~ "Listing Locations"
    end

    test "saves new map", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/locations")

      assert index_live |> element("a", "New Map") |> render_click() =~
               "New Map"

      assert_patch(index_live, ~p"/locations/new")

      assert index_live
             |> form("#map-form", map: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#map-form", map: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/locations")

      html = render(index_live)
      assert html =~ "Map created successfully"
    end

    test "updates map in listing", %{conn: conn, map: map} do
      {:ok, index_live, _html} = live(conn, ~p"/locations")

      assert index_live |> element("#locations-#{map.id} a", "Edit") |> render_click() =~
               "Edit Map"

      assert_patch(index_live, ~p"/locations/#{map}/edit")

      assert index_live
             |> form("#map-form", map: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#map-form", map: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/locations")

      html = render(index_live)
      assert html =~ "Map updated successfully"
    end

    test "deletes map in listing", %{conn: conn, map: map} do
      {:ok, index_live, _html} = live(conn, ~p"/locations")

      assert index_live |> element("#locations-#{map.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#locations-#{map.id}")
    end
  end

  describe "Show" do
    setup [:create_map]

    test "displays map", %{conn: conn, map: map} do
      {:ok, _show_live, html} = live(conn, ~p"/locations/#{map}")

      assert html =~ "Show Map"
    end

    test "updates map within modal", %{conn: conn, map: map} do
      {:ok, show_live, _html} = live(conn, ~p"/locations/#{map}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Map"

      assert_patch(show_live, ~p"/locations/#{map}/show/edit")

      assert show_live
             |> form("#map-form", map: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#map-form", map: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/locations/#{map}")

      html = render(show_live)
      assert html =~ "Map updated successfully"
    end
  end
end
