defmodule Problem1.Solution do
  @moduledoc """
  Find the sum of all multiples of 3 or 5 below N.

  ex:
  for N = 10
  3 + 5 + 6 + 9 = 23
  """

  @doc """
  Brute for solution using recursion
  """
  def calculate_multiples(base_num, current_num, sum, max) do
    new_num = base_num + current_num
    if new_num < max do
      calculate_multiples(base_num, new_num, sum + new_num, max)
    else
      sum
    end
  end

  @doc """
  Solution uses triangle numbers formula to compute sum
  """
  def triangle_calc(num, max) do
    if rem(max, num) != 0 do
      triangle_calc(num, max - 1)
    else
      div(num * div(max, num) * (div(max, num) + 1), 2)
    end
  end

  @doc """
  Compute solution based on input
  """
  defp compute_sum(max, :triangle) do
    threes = triangle_calc(3, max)
    fives = triangle_calc(5, max)
    fifteens = triangle_calc(15, max)
    threes + fives - fifteens
  end

  defp compute_sum(max, :brute_force) do
    threes = calculate_multiples(3, 0, 0, max)
    fives = calculate_multiples(5, 0, 0, max)
    fifteens = calculate_multiples(15, 0, 0, max)
    threes + fives - fifteens
  end

  @doc """
  Runs in the project euler plus app, reading IO input
  """
  def run do
    # skip initial line, because the input isn't meaningful
    IO.read(:stdio, :line)
    
    :stdio
    |> IO.stream(:line)
    |> Enum.each(fn n ->
      {max, _} = Integer.parse(n)
      result = compute_sum(max, :triangle)
      IO.puts(result)
    end)
  end

  @doc """
  Allows for running against an input locally

  ## Example

    iex> Problem1.Solution.run("problem_1/input.txt")

  """
  def run(file_path) do
    file_path
    |> File.stream!
    |> Stream.drop(1)
    |> Stream.each(fn n ->
      {max, _} = Integer.parse(n)
      result = compute_sum(max, :triangle)
      IO.puts(result)
    end)
    |> Stream.run()
  end
end
