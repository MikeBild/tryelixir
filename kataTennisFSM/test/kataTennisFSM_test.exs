defmodule KataTennisFSMFSMTest do
  use ExUnit.Case
  
  test "playerA should score" do
  	game = KataTennisFSM.start()
  	assert {{:A, 1}, {:B, 0}} == KataTennisFSM.score(game, :playerA)
  end
  test "playerA and playerB should score" do
  	game = KataTennisFSM.start()
  	KataTennisFSM.score(game, :playerA)
  	KataTennisFSM.score(game, :playerA)
  	KataTennisFSM.score(game, :playerB)
  	KataTennisFSM.score(game, :playerB)
  	assert {{:A, 3}, {:B, 2}} == KataTennisFSM.score(game, :playerA)
  end

 test "3, 3 should deuce" do
  	game = KataTennisFSM.start()
  	KataTennisFSM.score(game, :playerA)
  	KataTennisFSM.score(game, :playerA)
  	KataTennisFSM.score(game, :playerB)
  	KataTennisFSM.score(game, :playerB)
  	assert {{:A, 3}, {:B, 2}} == KataTennisFSM.score(game, :playerA)
  	assert :deuce == KataTennisFSM.score(game, :playerB)
  end

  test "4, 3 should adv playerA" do
  	game = KataTennisFSM.start()
  	KataTennisFSM.score(game, :playerA)
  	KataTennisFSM.score(game, :playerA)
  	KataTennisFSM.score(game, :playerA)
  	KataTennisFSM.score(game, :playerB)
  	KataTennisFSM.score(game, :playerB)
  	assert :deuce == KataTennisFSM.score(game, :playerB)
  	assert {{:A, :adv}, {:B, 3}} == KataTennisFSM.score(game, :playerA)
  end

  test "3, 4 should adv playerB" do
  	game = KataTennisFSM.start()
  	KataTennisFSM.score(game, :playerA)
  	KataTennisFSM.score(game, :playerA)
  	KataTennisFSM.score(game, :playerA)
  	KataTennisFSM.score(game, :playerB)
  	KataTennisFSM.score(game, :playerB)
  	assert :deuce == KataTennisFSM.score(game, :playerB)
  	assert {{:A, 3}, {:B, :adv}} == KataTennisFSM.score(game, :playerB)
  end
end