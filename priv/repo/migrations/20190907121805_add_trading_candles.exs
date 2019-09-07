defmodule Pifagor.Repo.Migrations.AddTradingCandles do
  use Ecto.Migration

  def change do
    create table(:trading_candles) do
      add :timeframe, :string, null: false
      add :status, :string, null: false
      add :open, :decimal, null: false
      add :low, :decimal
      add :high, :decimal
      add :close, :decimal
      add :close_time, :utc_datetime, null: false

      timestamps()
    end

    create index(:trading_candles, [:close_time])
    create index(:trading_candles, [:timeframe])
  end
end
