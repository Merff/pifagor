use Mix.Config

config :pifagor, ecto_repos: [Pifagor.Repo]

config :pifagor, :deribit,
  request_interval: 10_000,
  request_url: "https://test.deribit.com/api/v2/public/get_index?currency=BTC"

config :pifagor, :timeframes, ["1m", "5m", "1h", "4h", "1d", "1w"]

config :logger, level: :warn

import_config "#{Mix.env}.exs"
