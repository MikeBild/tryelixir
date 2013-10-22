defmodule KataTennisTest do
  use ExUnit.Case

  test "playerA should score" do
  	game = KataTennis.start([])
  	KataTennis.score(game, :playerA)
  	assert {:ok, {{:playerA, 1}, {:playerB, 0}, {:scoresA, "15"}, {:scoresB, "0"}}} == KataTennis.evaluate(game)
  end

  test "playerB should win" do
  	game = KataTennis.start([])
  	KataTennis.score(game, :playerA)
  	KataTennis.score(game, :playerA)
  	KataTennis.score(game, :playerB)
  	KataTennis.score(game, :playerB)
  	KataTennis.score(game, :playerB)
  	KataTennis.score(game, :playerB)

  	assert {:ok, {{:playerA, 2}, {:playerB, 5}, {:scoresA, "30"}, {:scoresB, "won"}}} == KataTennis.evaluate(game)
  end

  test "playerA should win" do
  	game = KataTennis.start([])
  	KataTennis.score(game, :playerA)
  	KataTennis.score(game, :playerB)
  	KataTennis.score(game, :playerB)
  	KataTennis.score(game, :playerA)
  	KataTennis.score(game, :playerA)
  	KataTennis.score(game, :playerA)

  	assert {:ok, {{:playerA, 5}, {:playerB, 2}, {:scoresA, "won"}, {:scoresB, "30"}}} == KataTennis.evaluate(game)
  end

  test "deuce" do
  	game = KataTennis.start([:playerA, :playerA, :playerA, :playerB, :playerB, :playerB])
  	assert {:ok, {{:playerA, 3}, {:playerB, 3}, {:scoresA, "40"}, {:scoresB, "40"}}} == KataTennis.evaluate(game)
  end

  test "playerA adv should win" do
  	game = KataTennis.start([:playerA, :playerA, :playerA, :playerB, :playerB, :playerB, :playerA, :playerB, :playerA, :playerB, :playerA, :playerA])
  	assert {:ok, {{:playerA, 5}, {:playerB, 3}, {:scoresA, "won"}, {:scoresB, "40"}}} == KataTennis.evaluate(game)
  end

  test "no transitions after won" do
  	game = KataTennis.start([:playerA, :playerA, :playerA, :playerB, :playerB, :playerB,:playerA, :playerA, :playerA, :playerA, :playerA, :playerA])
  	assert {:ok, {{:playerA, 5}, {:playerB, 3}, {:scoresA, "won"}, {:scoresB, "40"}}} == KataTennis.evaluate(game)
  end
end
