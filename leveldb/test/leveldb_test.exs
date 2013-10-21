defmodule LeveldbTest do
  use ExUnit.Case

  test "key 'a' should be value 'first'" do
  	Leveldb.store
  	{:ok, data} = Leveldb.get <<"a">>
    assert data == "first"
  end

  test "all should return 'first, second, third'" do
  	Leveldb.store
  	data = Leveldb.all
    assert data == [{"a", "first"}, {"b", "second"}, {"c", "third"}]
  end

  test "all with start key should return 'second, third'" do
    Leveldb.store
    data = Leveldb.all <<"b">>
    assert data == [{"b", "second"}, {"c", "third"}]
  end
end
