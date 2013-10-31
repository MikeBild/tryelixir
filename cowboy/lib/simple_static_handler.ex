defmodule Websocket.SimpleStaticHandler do
  @behaviour :cowboy_http_handler

  def init({_any, :http}, req, []) do
    {:ok, req, :undefined}
  end

  def handle(req, state) do
    {:ok, html_data} = File.read "priv/simple.html"
    {:ok, req} = :cowboy_req.reply 200, [{"Content-Type", "text/html"}], html_data, req
    {:ok, req, state}
  end

  def terminate(_reason, _request, _state) do
    :ok
  end
end

