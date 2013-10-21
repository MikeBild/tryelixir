defmodule ActorsTest do
  use ExUnit.Case

  test "it response to message" do
  	actor = spawn_link(Actors, :publish, [])
    verify_out "demo", actor
  end

  def verify_out(expected, actor) do
  	actor <- {:in, self()}
    assert_receive {:out, ^expected}
  end
end
