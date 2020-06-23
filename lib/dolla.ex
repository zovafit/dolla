defmodule Dolla do
  use Application

  def start(_type, _args) do
    children = [
    ]

    opts = [strategy: :one_for_one, name: Dolla.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defdelegate verify(receipt_data), to: Dolla.Client
end
