defmodule TicTacToe do
  @moduledoc """
  Implementation of a Tic Tac Toe.
  """

  @doc """
  
  This method verifies if someone won the game,
  given a final state

  """
  def winner(game) do
    {a, b, c, d, e, f, g, h, i} = game

    cond do
      a == b and b == c -> {:winner, a}
      d == e and e == f -> {:winner, d}
      g == h and h == i -> {:winner, g}
      a == d and d == g -> {:winner, a}
      b == e and e == h -> {:winner, b}
      c == f and f == i -> {:winner, c}
      a == e and e == i -> {:winner, a}
      c == e and e == g -> {:winner, c}
      true        -> :no_winner
    end

  end
end
