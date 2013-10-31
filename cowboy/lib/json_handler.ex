defmodule Websocket.JsonHandler do
  @behaviour :cowboy_http_handler

  def init({_any, :http }, req, []) do
    { :ok, req, :undefined }
  end

  def handle(req, state) do
	{:ok, input, _} = :cowboy_req.body(:infinity, req)

  	case :cowboy_req.method(req) do
  		{"GET", _} -> data = [result: "'GET' this will be a elixir result"]
  		{"POST", _} -> {:ok, data} = JSON.decode(input)
  	end
  	
  	{:ok, result} = JSON.encode(data)
    {:ok, req} = :cowboy_req.reply 200, [{"Content-Type", "application/json"}], result, req
    {:ok, req, state}
  end

  def terminate(_reason, _request, _state) do
    :ok
  end
end