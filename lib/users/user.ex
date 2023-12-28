defmodule YourApp.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema  # This includes the fields required by Pow

  @primary_key {:id, :binary_id, autogenerate: true}  # using UUIDs for ids
  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string  # Pow uses this for storing password hash

    pow_user_fields()  # Macro that injects fields required by Pow

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> pow_changeset(attrs)  # Pow changeset for handling password hashing
    |> Ecto.Changeset.cast(attrs, [:name])
    |> Ecto.Changeset.validate_required([:email, :name])
  end
end
