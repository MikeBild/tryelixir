defmodule KataTennis do
	use GenServer.Behaviour

	def init(items) do
		{:ok, items }
	end

	def handle_call({:score, item}, _from, items) do
		{:reply, :ok, items ++ [item] }
	end

	def handle_call({:evaluate}, _from, items) do
		result = Enum.reduce(items, {{:playerA, 0}, {:playerB, 0}, {:scoresA, 0}, {:scoresB, 0}}, fn(n, acc) -> sum(n, acc) end)
		{:reply, {:ok, result}, items}
	end

	defp sum(n, acc) do
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
