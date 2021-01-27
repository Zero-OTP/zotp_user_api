defmodule ZotpUserApi.Endpoint do
  use Plug.Router

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json, :urlencoded],
    pass: ["application/json","text/*"],
    json_decoder: Poison
  )

  forward("/api/v1", to: ZotpUserApi.Router) # Todas las peticiones a /api/v1 se enviaran a nuestro router

  plug(:dispatch)

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

  # AutoSpawn para el endpoint

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(_opts) do
    Plug.Adapters.Cowboy2.http(__MODULE__, [])
  end
end
