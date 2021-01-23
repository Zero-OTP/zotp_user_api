defmodule ZotpUserApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      ZotpUserApi.Endpoint
      # Starts a worker by calling: ZotpUserApi.Worker.start_link(arg)
      # {ZotpUserApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ZotpUserApi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
