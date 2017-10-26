defmodule Herps.MessengerTest do
  use ExUnit.Case
  doctest Herps.Messenger

  test "greets the world" do
    assert Herps.Messenger.hello() == :world
  end
end
