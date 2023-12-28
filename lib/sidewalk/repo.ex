defmodule Sidewalk.Repo do
  use Ecto.Repo,
    otp_app: :sidewalk,
    adapter: Ecto.Adapters.Postgres
end
