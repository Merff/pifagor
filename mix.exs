defmodule Pifagor.MixProject do
  use Mix.Project

  def project do
    [
      app: :pifagor,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Pifagor, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:httpoison, "~> 1.5"},
      {:timex, "~> 3.6"},
      {:jason, "~> 1.0"}
    ]
  end
end
