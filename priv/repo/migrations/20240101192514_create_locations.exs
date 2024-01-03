defmodule Sidewalk.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do 
      add :latitude, :float
      add :longitude, :float
      add :description, :string

      timestamps()
    end
  end
end
