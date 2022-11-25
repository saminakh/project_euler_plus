defmodule Problem2.Solution do
  @moduledoc """
  By considering the terms in the Fibonacci sequence whose values do not exceed N,
  find the sum of the even-valued terms.

  ex:
  for N = 10
  2 + 8 = 10
  """

  def compute_sum(a, b, total, max) do
    c = a + b
    if c >= max do
      total
    else
      if rem(a + b, 2) == 0 do
        compute_sum(b, c, total + a + b, max)
      else
        compute_sum(b, c, total, max)
      end
    end       
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
      result = compute_sum(1, 2, 2, max)
      IO.puts(result)
    end)
  end

  @doc """
  Allows for running against an input locally

  ## Example

    iex> Problem2.Solution.run("problem_2/input.txt")

  """
  def run(file_path) do
    file_path
    |> File.stream!
    |> Stream.drop(1)
    |> Stream.each(fn n ->
      {max, _} = Integer.parse(n)
      result = compute_sum(1, 2, 2, max)
      IO.puts(result)
    end)
    |> Stream.run()
  end
end
