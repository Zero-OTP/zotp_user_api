defmodule ZotpUserApi.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(message()))
  end

  get "/userinfo" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(ZotpUserLib.User.new("a","b","c") |> ZotpUserLib.User.get()))
  end

  defp message do
    %{
      response_type: "in_channel",
      text: "Hello from API v1 :)"
    }
  end
end
