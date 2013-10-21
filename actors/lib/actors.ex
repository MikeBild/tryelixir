defmodule Actors do
@moduledoc """ 
	Actors Demo 
"""
	@doc """
	Publish a message.
	"""
	def publish do
		receive do
			{:in, pid} -> out(pid)
		end
		publish
	end
	def out(pid) do
		pid <- {:out, "demo"}
	end
end
