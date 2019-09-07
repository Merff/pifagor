defmodule Pifagor.TradingCandle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trading_candle" do
    field :timeframe, :string
    field :status, :string
    field :open, :decimal
    field :low, :decimal
    field :high, :decimal
    field :close, :decimal
    field :close_time, :naive_datetime

    timestamps()
  end

  @required [
    :timeframe,
    :status,
    :open,
    :close_time
  ]

  @optional [
    :low,
    :high,
    :close
  ]

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
  end
end
