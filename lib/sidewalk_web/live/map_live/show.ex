defmodule SidewalkWeb.MapLive.Show do
  use SidewalkWeb, :live_view

  alias Sidewalk.Location

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:map, Location.get_map!(id))}
  end

  defp page_title(:show), do: "Show Map"
  defp page_title(:edit), do: "Edit Map"
end
