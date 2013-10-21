defmodule ActorsTest do
  use ExUnit.Case

  test "it response to message" do
  	actor = spawn_link(Actors, :publish, [])
  	actor <- {:in, self()}
  	assert_receive {:out, {:msg,"demo"},{:count, 0}}
  end
  
  test "it response with count 1 to messages" do
  	actor = spawn_link(Actors, :publish, [])
  	actor <- {:in, self()}
  	actor <- {:in, self()}
  	assert_receive {:out, {:msg,"demo"},{:count, 1}}
  end
end
