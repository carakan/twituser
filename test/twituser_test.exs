defmodule TwituserTest do
  use ExUnit.Case
  doctest Twituser

  test "greets the world" do
    assert Twituser.hello() == :world
  end
end
