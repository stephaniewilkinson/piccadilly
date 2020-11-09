defmodule Piccadilly.Repo do
  use Ecto.Repo,
    otp_app: :piccadilly,
    adapter: Ecto.Adapters.Postgres
end
