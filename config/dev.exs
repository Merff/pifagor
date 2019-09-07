use Mix.Config

config :pifagor, Pifagor.Repo,
  database: "pifagor_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :logger, level: :debug
