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
    assert [{"a", "first"}, {"b", "second"}, {"c", "third"}] == data
  end

  test "all with start key should return 'second, third'" do
    data = Leveldb.all <<"b">>
    assert [{"b", "second"}, {"c", "third"}] == data
  end

  test "iterator shold return values" do
     {:ok, data} = Leveldb.range <<"c">>, <<>>
     assert [{"c", "third"}] == data
  end

  teardown do
    :ok
  end
end
