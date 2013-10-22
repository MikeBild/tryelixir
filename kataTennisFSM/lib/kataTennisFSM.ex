defmodule KataTennisFSM do
	use GenFSM.Behaviour

	#public API
	def start do
		{:ok, game} = :gen_fsm.start_link(KataTennisFSM, [], [])
		game
	end

	def score(game, player) do
		:gen_fsm.sync_send_event(game, player)
	end

	def evaluate(game) do
		:gen_fsm.sync_send_event(game)
	end

	#GenFSM API
	def init(_) do
		{:ok, :score, {{:A, 0}, {:B, 0}}}
	end

	def score(:playerA, _from, state_data) do
		{{:A, a}, {:B, b}} = state_data
		state_data = {{:A, a+1}, {:B, b}}
		{:reply, state_data, :score, state_data}
	end

	def score(:playerB, _from, state_data) do
		{{:A, a}, {:B, b}} = state_data
		state_data = {{:A, a}, {:B, b+1}}
		{:reply, state_data, :score, state_data}
	end
end
