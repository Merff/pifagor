defmodule Pifagor.Repo do
  use Ecto.Repo,
    otp_app: :pifagor,
    adapter: Ecto.Adapters.Postgres
end
