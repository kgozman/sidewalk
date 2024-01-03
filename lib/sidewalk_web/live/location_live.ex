defmodule Sidewalk.LocationLive do
    use Phoenix.LiveView
    alias Sidewalk.Locations
    alias Sidewalk.Repo
    def mount(_params, _session, socket) do
        {:ok, assign(socket, :locations, [])}
    end

    def handle_event("load_locations", _value, socket) do  
        locations = Repo.transaction(fn -> 
            stream = Repo.stream(Locations.get_location_query())
            Enum.to_list(stream)
        end)

        case locations do 
            {:ok, results} -> {:noreply, assign(socket, :locations, results)}
            {:error, reason} -> {:noreply, socket}
        end
    end
end