defmodule KataTennisTest do
  use ExUnit.Case

  test "start should return :ok" do
  	{:ok, game} = :gen_server.start_link KataTennis, [], []
  	assert :ok == :gen_server.call(game, {:score, :playerA})
  end

  test "playerA should scored" do
  	{:ok, game} = :gen_server.start_link KataTennis, [], []
  	:gen_server.call(game, {:score, :playerA})
  	assert {:ok, {{:playerA, 1}, {:playerB, 0}, {:scoresA, "15"}, {:scoresB, "0"}}} == :gen_server.call(game, {:evaluate})
  end

    test "playerA should win" do
  	{:ok, game} = :gen_server.start_link KataTennis, [], []
  	:gen_server.call(game, {:score, :playerA})
  	:gen_server.call(game, {:score, :playerA})
  	:gen_server.call(game, {:score, :playerA})
  	:gen_server.call(game, {:score, :playerB})
  	:gen_server.call(game, {:score, :playerB})
  	:gen_server.call(game, {:score, :playerB})
  	:gen_server.call(game, {:score, :playerA})
  	:gen_server.call(game, {:score, :playerB})
  	:gen_server.call(game, {:score, :playerA})
  	:gen_server.call(game, {:score, :playerA})
  	:gen_server.call(game, {:score, :playerA})
  	:gen_server.call(game, {:score, :playerA})
  	:gen_server.call(game, {:score, :playerA})

  	assert {:ok, {{:playerA, 5}, {:playerB, 3}, {:scoresA, "won"}, {:scoresB, "40"}}} == :gen_server.call(game, {:evaluate})
  end
end
