defmodule BankAccount do

	def start do
		await([])
	end

	def await(events) do
		receive do
			{:checkBalance, pid} -> checkBalance(pid, events)
			{:deposit, amount} -> events = deposit(amount, events)
			{:withdraw, amount} -> events = withdraw(amount, events)
		end
		await(events)
	end

	defp checkBalance(pid, events) do
		balance = Enum.reduce(events, 0, fn({_, value}, acc) -> acc + value end)
		pid <- {:ok, balance}
	end

	defp deposit(amount, events) do
		events ++ [{:deposit, amount}]
	end
	defp withdraw(amount, events) do
		events ++ [{:withdraw, 0-amount}]
	end

end
