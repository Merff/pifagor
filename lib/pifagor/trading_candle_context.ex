defmodule Pifagor.TradingCandleContext do

  import Ecto.Query
  require Logger
  alias Pifagor.{Repo, TradingCandle}

  def process(nil), do: Logger.error("get empty current_rate")
  def process(current_rate) do
    current_time = Timex.now()

    ["1m", "5m", "1h", "4h", "1d", "1w"]
    |> Enum.each(fn timeframe ->
      find_or_create_trading_candle!(timeframe, current_rate, current_time)
      |> update_rates!(current_rate)
    end)

    close_trading_candles(current_rate, current_time)
  end

  defp find_or_create_trading_candle!(timeframe, current_rate, current_time) do
    from(c in TradingCandle,
      where:
        c.timeframe == ^timeframe and
        c.status == "open" and
        c.close_time <= ^current_time
    )
    |> Repo.one()
    |> case do
      nil ->
        %TradingCandle{
          timeframe: timeframe,
          status: "open",
          open: current_rate,
          low: current_rate,
          high: current_rate,
          close_time: get_close_time(timeframe, current_time)
        }
        |> TradingCandle.changeset()
        |> Repo.insert!()
      record ->
        record
    end
  end

  defp close_trading_candles(current_rate, current_time) do
    from(c in TradingCandle,
      where: c.close_time >= ^current_time
    )
    |> Repo.update_all(set: [status: "close", close: current_rate])
  end

  defp update_rates!(trading_candle, current_rate) do
    params = %{
      low: min(trading_candle.low, current_rate),
      high: max(trading_candle.high, current_rate)
    }

    trading_candle
    |> TradingCandle.changeset(params)
    |> Repo.update!(params)
  end

  defp get_close_time(timeframe, current_time) do
    minutes =
      case timeframe do
        "1m" -> 1
        "5m" -> 5
        "1h" -> 60
        "4h" -> 240
        "1d" -> 1440
        "1w" -> 10_080
      end

    Timex.shift(current_time, minutes: minutes)
  end

end
