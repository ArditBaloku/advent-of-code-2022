defmodule AdventOfCode.Day06 do
  def part1(args) do
    args
    |> String.split("", trim: true)
    |> Enum.chunk_every(4, 1, :discard)
    |> Enum.find_index(fn x -> Enum.uniq(x) |> Enum.count() == 4 end)
    |> Kernel.+(4)
  end

  def part2(args) do
    args
    |> String.split("", trim: true)
    |> Enum.chunk_every(14, 1, :discard)
    |> Enum.find_index(fn x -> Enum.uniq(x) |> Enum.count() == 14 end)
    |> Kernel.+(14)
  end
end
