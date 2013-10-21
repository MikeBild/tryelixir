defmodule LeveldbTest do
  use ExUnit.Case


  setup do
    Leveldb.store
    :ok
  end

  test "key 'a' should be value 'first'" do
  	{:ok, data} = Leveldb.get <<"a">>
    assert data == "1"
  end

  test "all should return 'first, second, third'" do
  	data = Leveldb.all
    assert [{"a", "1"}, {"b", "2"}, {"c", "3"},{"d", "4"}, {"e", "5"}] == data
  end

  test "all with start key should return 'second, third'" do
    data = Leveldb.all <<"b">>
    assert [{"b", "2"}, {"c", "3"},{"d", "4"}, {"e", "5"}] == data
  end

  test "iterator shold return all values" do
     {:ok, data} = Leveldb.range <<>>, <<>>
     assert [{"a", "1"}, {"b", "2"}, {"c", "3"},{"d", "4"}, {"e", "5"}] == data
  end

  test "iterator from 'a' to 'b' shold return values" do
     {:ok, data} = Leveldb.range <<"a">>, <<"c">>
     assert [{"a", "1"}, {"b", "2"}] == data
  end

  test "iterator from 'b' to 'c' shold return values" do
     {:ok, data} = Leveldb.range <<"b">>, <<"d">>
     assert [{"b", "2"}, {"c", "3"}] == data
  end
  teardown do
    :ok
  end
end
