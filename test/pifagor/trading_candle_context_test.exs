defmodule Pifagor.TradingCandleContextTest do
  use ExUnit.Case

  alias Pifagor.{Repo, TradingCandle, TradingCandleContext}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "process/3" do

    @timeframe "1m"
    @open_rate 9405.4
    @curent_rate 10405.47
    @current_time DateTime.truncate(Timex.now(), :second)

    test "when empty storage save new candle" do
      TradingCandleContext.process(@timeframe, @curent_rate, @current_time)

      [candle] = Repo.all(TradingCandle)

      assert candle.timeframe == @timeframe
      assert candle.open == Decimal.from_float(@curent_rate)
    end

    test "when open candles exist update rates" do
      create_candle!(
        %{
          timeframe: @timeframe,
          status: "open",
          open: @open_rate,
          low: @open_rate,
          high: @open_rate,
          close_time: Timex.shift(@current_time, seconds: -30)
        }
      )

      TradingCandleContext.process(@timeframe, @curent_rate, @current_time)

      [candle] = Repo.all(TradingCandle)

      assert candle.low == Decimal.from_float(@open_rate)
      assert candle.high == Decimal.from_float(@curent_rate)
      assert candle.status == "open"
      assert candle.close == nil
    end

    test "when close_time expire close candle" do
      create_candle!(
        %{
          timeframe: @timeframe,
          status: "open",
          open: @open_rate,
          low: @open_rate,
          high: @open_rate,
          close_time: @current_time
        }
      )

      TradingCandleContext.process(@timeframe, @curent_rate, @current_time)

      [candle] = Repo.all(TradingCandle)

      assert candle.low == Decimal.from_float(@open_rate)
      assert candle.high == Decimal.from_float(@curent_rate)
      assert candle.status == "close"
      assert candle.close == Decimal.from_float(@curent_rate)
    end

  end

  defp create_candle!(attrs) do
    %TradingCandle{}
    |> TradingCandle.changeset(attrs)
    |> Repo.insert!()
  end

end
