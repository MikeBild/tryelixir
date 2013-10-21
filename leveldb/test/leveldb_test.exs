defmodule LeveldbTest do
  use ExUnit.Case


  setup do
    Leveldb.store
    :ok
  end

  test "key 'a' should be value 'first'" do
  	{:ok, data} = Leveldb.get <<"a">>
    assert data == "first"
  end

  test "all should return 'first, second, third'" do
  	data = Leveldb.all
    assert data == [{"a", "first"}, {"b", "second"}, {"c", "third"}]
  end

  test "all with start key should return 'second, third'" do
    data = Leveldb.all <<"b">>
    assert data == [{"b", "second"}, {"c", "third"}]
  end

  teardown do
    :ok
  end
end
