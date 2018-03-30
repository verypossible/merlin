defmodule MerlinTest do
  use ExUnit.Case
  doctest Merlin

  test "greets the world" do
    assert Merlin.hello() == :world
  end
end
