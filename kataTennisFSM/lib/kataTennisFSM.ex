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

	#GenFSM API
	def init(_) do
		{:ok, :score, {{:A, 0}, {:B, 0}}}
	end

	def score(:playerA, _from, state_data) do
		{{:A, a}, {:B, b}} = state_data
		evaluate {{:A, a+1}, {:B, b}}
	end

	def score(:playerB, _from, state_data) do
		{{:A, a}, {:B, b}} = state_data
		evaluate {{:A, a}, {:B, b+1}}
	end

	def deuce(:playerA, _from, state_data), do:
 		{:reply, {{:A, :adv}, {:B, 3}}, :score, state_data}

	def deuce(:playerB, _from, state_data), do:
 		{:reply, {{:A, 3}, {:B, :adv}}, :score, state_data}

	defp evaluate({{:A, a}, {:B, b}}) when a==3 and b==3, do: {:reply, :deuce, :deuce, {{:A, a}, {:B, b}}}

	defp evaluate(state_data), do: {:reply, state_data, :score, state_data}
end
