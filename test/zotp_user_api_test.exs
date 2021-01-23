defmodule ZotpUserApiTest do
  use ExUnit.Case
  doctest ZotpUserApi

  test "greets the world" do
    assert ZotpUserApi.hello() == :world
  end
end
