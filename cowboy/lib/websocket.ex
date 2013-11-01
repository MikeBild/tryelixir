defmodule Websocket do
  use Application.Behaviour
  
  def start(_type, _args) do
    dispatch = :cowboy_router.compile([{:_, [
      {"/ws", Websocket.WsHandler, []},
      {"/simple", Websocket.SimpleStaticHandler, []},
      {"/hello", Websocket.HelloHandler, []},
      {"/json", Websocket.JsonHandler, []},
      { "/index", :cowboy_static, [ directory: {:priv_dir, :cowboy, []}, file: "index.html", mimetypes: {&:mimetypes.path_to_mimes/2, :default}]},
      {:_, Websocket.AllHandler, []}
    ]}])
    
    :cowboy.start_http(:http, 100, [port: 8080], [env: [dispatch: dispatch]])
    IO.puts "Started listening on port 8080..."

    Websocket.Supervisor.start_link
  end

  def exit do
    stop(:ok)
    System.halt(0)
  end
end
