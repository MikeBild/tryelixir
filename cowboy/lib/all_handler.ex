defmodule Websocket.AllHandler do
  @behaviour :cowboy_http_handler

  def init({_any, :http }, req, []) do
    { :ok, req, :undefined }
  end

  def handle(req, state) do
	{:ok, input, _} = :cowboy_req.body(:infinity, req)
	IO.puts inspect :cowboy_req.method(req)
	IO.puts inspect :cowboy_req.path(req)
	IO.puts inspect :cowboy_req.path_info(req)
    {:ok, req} = :cowboy_req.reply 200, [], "done!", req
    {:ok, req, state}
  end

  def terminate(_reason, _request, _state) do
    :ok
  end
end