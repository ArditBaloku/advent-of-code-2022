defmodule AdventOfCode.Day01 do
  def part1(args) do
    args
    |> sum_values()
    |> Enum.max()
  end

  def part2(args) do
    args
    |> sum_values()
    |> Enum.sort()
    |> Enum.take(-3)
    |> Enum.sum()
  end

  defp sum_values(args) do
    args
    |> String.split("\n")
    |> Enum.reduce(%{:elf => 0}, fn x, acc -> count_calories(x, acc) end)
    |> Map.values()
  end

  defp count_calories("", acc) do
    Map.put(acc, :elf, acc[:elf] + 1)
  end

  defp count_calories(line, acc) do
    Map.put(acc, acc[:elf], String.to_integer(line) + Map.get(acc, acc[:elf], 0))
  end
end
