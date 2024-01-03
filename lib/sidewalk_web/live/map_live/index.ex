defmodule SidewalkWeb.MapLive.Index do
  use SidewalkWeb, :live_view

  alias Sidewalk.Location
  alias Sidewalk.Location.Map

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :locations, Location.list_locations())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Map")
    |> assign(:map, Location.get_map!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Map")
    |> assign(:map, %Map{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Locations")
    |> assign(:map, nil)
  end

  @impl true
  def handle_info({SidewalkWeb.MapLive.FormComponent, {:saved, map}}, socket) do
    {:noreply, stream_insert(socket, :locations, map)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    map = Location.get_map!(id)
    {:ok, _} = Location.delete_map(map)

    {:noreply, stream_delete(socket, :locations, map)}
  end
end
