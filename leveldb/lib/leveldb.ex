defmodule Leveldb do

	def store do
		{:ok, ldb} = :eleveldb.open('testdb',[{:create_if_missing, true}])
		try do
			:ok = :eleveldb.put ldb, <<"a">>, <<"first">>, []
			:ok = :eleveldb.put ldb, <<"b">>, <<"second">>, []
			:ok = :eleveldb.put ldb, <<"c">>, <<"third">>, []
		after
			:eleveldb.close ldb
		end
	end

	def get(key) do
		{:ok, ldb} = :eleveldb.open('testdb',[{:create_if_missing, true}])
		try do
			:eleveldb.get(ldb, key, [])			
		after
			:eleveldb.close ldb
		end
	end

	def all do
		{:ok, ldb} = :eleveldb.open('testdb',[{:create_if_missing, true}])
		try do
			:eleveldb.fold ldb, fn(n, acc)-> acc ++ [n] end, [], []
		after
			:eleveldb.close ldb
		end
	end

	def all(start) do
		{:ok, ldb} = :eleveldb.open('testdb',[{:create_if_missing, true}])
		try do
			:eleveldb.fold ldb, fn(n, acc)-> acc ++ [n] end, [], [{:first_key, start}]
		after
			:eleveldb.close ldb
		end
	end

	def range(from, to) do
		{:ok, ldb} = :eleveldb.open('testdb',[{:create_if_missing, true}])
		try do
			{:ok, i} = :eleveldb.iterator ldb, []
			
			next i, [], from, to
		after
			:eleveldb.close ldb
		end
	end

	defp next(i, acc, from, to) do
		case acc do
			[] -> data = :eleveldb.iterator_move(i, from)
			_  -> data = :eleveldb.iterator_move(i, :next)
		end
		n = fn
			{:ok, key, value} -> next(i, acc ++ [{key, value}], from, to)
			{:error, :invalid_iterator} -> {:ok, acc}
		end
		n.(data)
	end
	
end
