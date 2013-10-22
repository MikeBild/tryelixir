defmodule KataTennis do
	use GenServer.Behaviour

	#public API
	def start(items) do
	  	{:ok, game} = :gen_server.start_link KataTennis, items, []
	  	game
	end

	def score(game, player) do
		:gen_server.cast(game, {:score, player})
	end

	def evaluate(game) do
		:gen_server.call(game, {:evaluate})
	end


	#GenServer API

	def init(items) do
		{:ok, items }
	end

	def handle_cast({:score, item}, items) do
		{:noreply, items ++ [item] }
	end

	def handle_call({:evaluate}, _from, items) do
		items
		|> Enum.reduce({{:playerA, 0}, {:playerB, 0}, {:scoresA, 0}, {:scoresB, 0}}, evaluate(&1, &2))
		|> (& {:reply, {:ok, &1}, items}).()
	end

	defp evaluate(n, acc) do
		scoreCard = ["0","15","30","40","adv","won"]
		{{:playerA, a}, {:playerB, b}, {:scoresA, _}, {:scoresB, _}} = acc
		case acc do
			{{:playerA, 5},{:playerB,_},{_,_},{_,_}} -> a=a
			{{:playerA,_},{:playerB, 5},{_,_},{_,_}} -> b=b
			{{^n,x},{:playerB,y},{_,_},{_,_}} when x === 3 and y<3 -> a=5			
			{{:playerA,x},{^n,y},{_,_},{_,_}} when y === 3 and x<3 -> b=5		
			{{^n,x},{:playerB,y},{_,_},{_,_}} when y === 4 and x===3 -> b=3			
			{{:playerA,x},{^n,y},{_,_},{_,_}} when x === 4 and y===3 -> a=3		
			{{^n,_},{:playerB,_},{_,_},{_,_}} -> a=a+1
			{{:playerA,_},{^n,_},{_,_},{_,_}} -> b=b+1
		end

		{{:playerA, a}, {:playerB, b}, {:scoresA, Enum.at(scoreCard, a)}, {:scoresB, Enum.at(scoreCard, b)}}
	end
end
