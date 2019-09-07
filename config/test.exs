use Mix.Config

config :pifagor, Pifagor.Repo,
  username: "postgres",
  password: "postgres",
  database: "pifagor_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

