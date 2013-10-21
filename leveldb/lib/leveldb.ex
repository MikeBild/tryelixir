defmodule Leveldb do

	def store do
		{:ok, ldb} = :eleveldb.open('testdb',[{:create_if_missing, true}])
		try do
			:ok = :eleveldb.put ldb, <<"a">>, <<"1">>, []
			:ok = :eleveldb.put ldb, <<"b">>, <<"2">>, []
			:ok = :eleveldb.put ldb, <<"c">>, <<"3">>, []
			:ok = :eleveldb.put ldb, <<"d">>, <<"4">>, []
			:ok = :eleveldb.put ldb, <<"e">>, <<"5">>, []

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
			{:ok, key, value} = :eleveldb.iterator_move(i, from)
			next i, [] ++ [{key, value}], to
		after
			:eleveldb.close ldb
		end
	end

	defp next(i, acc, to) do
		(fn
			{:ok, key, value} when key != to -> next(i, acc ++ [{key, value}], to)
			_ -> {:ok, acc}
		end).(:eleveldb.iterator_move(i, :next))
	end
	
end
