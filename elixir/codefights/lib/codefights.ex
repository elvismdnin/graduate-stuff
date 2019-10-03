defmodule Codefights do
  @moduledoc """
  Codes for challenges of Codefights.
  """

  def containsDuplicates(vector) do
    length(Enum.uniq(vector)) != length(vector)
  end

  def sumOfTwo(a, b, v) do
    sortedSumOfTwo(Enum.sort(a), Enum.sort(b), v)
  end

  def sortedSumOfTwo([x|a], [y|b], v) do
    if x+y > v do
      false
    else
      verifySortedLine(x, [y|b], v) or sortedSumOfTwo(a, [y|b], v)
    end
  end

  def sortedSumOfTwo([], [y|b], v) do
    false
  end

  def verifySortedLine(x, [y|b], v) do
    cond do
      x+y > v ->
        false
      x+y == v ->
        true
      true ->
        verifySortedLine(x, b, v)
    end
  end

  def verifySortedLine(x, [], v) do
    false
  end

end
