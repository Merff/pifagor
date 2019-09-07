use Mix.Config

config :pifagor, ecto_repos: [Pifagor.Repo]

config :pifagor, Pifagor.Repo,
  database: "pifagor_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5432"

config :pifagor, :deribit,
  request_interval: 10_000,
  request_url: "https://test.deribit.com/api/v2/public/get_index?currency=BTC"
