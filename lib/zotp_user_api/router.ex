defmodule ZotpUserApi.Router do
  @moduledoc """
  ZotpUserApi.Router file.

  ## Available endpoints:

  /
  /login
  /userinfo

  ## /
        This returns hello from Api

  ## /login endpoint

      Takes a JSON Input by POST, returns session

      Returns `
      {
          "session": {
                      "user_id": 2,
                      "session_token": "dec3c604-d270-4141-ba89-97e8b9b8b8f0",
                      "last_update": "2021-01-26T17:22:13.365867Z",
                      "creation_date": "2021-01-26T17:22:13.365867Z"
                    }
      }
    or "error" if user is invalid`.

  ## Examples

    {
      "email": "a"
      "pass": "b",
      "nick": "c",
    }

  ## /userinfo

        For testing purposes, must be removed

  """
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(message()))
  end

  post "/login" do
    body = conn.body_params
    #IO.inspect(body)
    in_user = body |> parse_body_as_user
    #IO.inspect(in_user)
    user = ZotpUserLib.User.get(in_user) |> List.first
    #IO.inspect(user)
    in_session = user |> parse_and_get_session
    #IO.inspect(in_session)
    response = %{"session" => in_session}
    send_resp(conn |> put_resp_content_type("application/json"), 200, Poison.encode!(response))
  end

  get "/userinfo" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(ZotpUserLib.User.new("a","b","c") |> ZotpUserLib.User.get()))
  end

  # HELPER FUNCTIONS FOR ENDPOINTS

  defp message do
    %{
      response_type: "in_channel",
      text: "Hello from API v1 :)"
    }
  end

  defp parse_body_as_user(body) do
    case body do
      #Filter input format by match
      %{"email" => _,  "nick" => _, "pass" => _} ->
        Poison.encode!(body) |> Poison.decode!(as: %ZotpUserLib.User{})
      _ ->
        "error"
    end
  end

  defp parse_and_get_session(user) do
    case user do
      nil ->
        "no user to retrieve session"
      _ ->
        #existing session
        tmp_session =
          ZotpUserLib.UserSession.new(user.id)
          |>ZotpUserLib.UserSession.get
          |>List.first
        #IO.inspect(tmp_session)
        case tmp_session do
        #unexisting session, but user is valid, create and insert a new one in DB
          nil -> ZotpUserLib.UserSession.new(user.id) |> ZotpUserLib.UserSession.create
          _ -> tmp_session
        end
    end
  end

end
