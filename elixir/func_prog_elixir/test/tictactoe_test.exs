defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "X winner" do
    assert TicTacToe.winner({
      :x, :o, :x,
      :o, :x, :o,
      :o, :o, :x
    }) == {:winner, :x}
  end

  test "Nobody wins" do
    assert TicTacToe.winner({
      :x, :o, :x,
      :o, :x, :o,
      :o, :x, :o
    }) == :no_winner
  end
end
