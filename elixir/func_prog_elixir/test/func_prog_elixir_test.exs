defmodule FuncProgElixirTest do
  use ExUnit.Case
  doctest FuncProgElixir

  test "greets the world" do
    assert FuncProgElixir.hello() == :world
  end
end
