defmodule Websocket.Mixfile do
  use Mix.Project

  def project do
    [ app: :websocket,
      version: "0.0.1",
      elixir: "~> 0.10.3",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      applications: [:mimetypes, :ranch, :cowboy, :lager],
      mod: { Websocket, [] }
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      {:cowboy, github: "extend/cowboy"},
      {:mimetypes, github: "spawngrid/mimetypes"},
      {:lager, github: "basho/lager" },
      {:json, github: "cblage/elixir-json"}
    ]
  end
end
