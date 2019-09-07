defmodule Pifagor do
  use Application

  def start(_type, _args) do
    children = [
      Pifagor.Repo
    ]

    opts = [strategy: :one_for_one, name: Pifagor.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
