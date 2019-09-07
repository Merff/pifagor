use Mix.Config

config :pifagor, ecto_repos: [Pifagor.Repo]

config :pifagor, Pifagor.Repo,
  database: "pifagor_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5432"
