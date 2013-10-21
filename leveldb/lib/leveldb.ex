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
			:eleveldb.fold ldb, fn(n, acc)-> acc ++ [n] end, [], [{:first_key, <<"">>}]
		after
			:eleveldb.close ldb
		end
	end
end
