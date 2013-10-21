defmodule Actors do
@moduledoc """ 
	Actors Demo 
"""
	@doc """
	Publish a message.
	"""
	def publish do
		publish(0)
	end

	def publish(count) do
		receive do
			{:in, pid} -> pid <- {:out, {:msg, "demo"}, {:count, count}}
		end
		publish(count + 1)
	end
end
