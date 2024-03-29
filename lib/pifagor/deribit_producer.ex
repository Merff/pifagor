defmodule Pifagor.DeribitProducer do
  use GenServer
  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, :normal)
  end

  def init(:normal) do
    {:ok, [], {:continue, :start_schedule_work}}
  end

  def handle_continue(:start_schedule_work, state) do
    schedule_work()
    {:noreply, state}
  end

  def handle_info(:get_data, state) do
    current_rate = api_get_current_rate()
    current_time = Timex.now() |> DateTime.truncate(:second)

    Application.fetch_env!(:pifagor, :timeframes)
    |> Enum.each(fn timeframe ->
      Pifagor.TradingCandleContext.process(timeframe, current_rate, current_time)
    end)

    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(
      self(),
      :get_data,
      Application.fetch_env!(:pifagor, :deribit)[:request_interval]
    )
  end

  defp api_get_current_rate() do
    api_url = Application.fetch_env!(:pifagor, :deribit)[:request_url]

    case HTTPoison.get(api_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: resp}} ->
        Jason.decode!(resp)
        |> get_in(["result", "BTC"])
      _ ->
        Logger.error("#{api_url} not available")
        nil
    end
  end
end
