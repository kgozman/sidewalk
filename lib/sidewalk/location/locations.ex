defmodule Sidewalk.Locations.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :latitude, :float
    field :longitude, :float
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:latitude, :longitude, :description])
    |> validate_required([:latitude, :longitude, :description])
  end
end