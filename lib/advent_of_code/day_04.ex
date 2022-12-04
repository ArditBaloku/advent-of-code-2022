defmodule AdventOfCode.Day04 do
  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.filter(&assignment_is_contained?/1)
    |> Enum.count()
  end

  defp assignment_is_contained?(line) do
    [leftElfOne, leftElfTwo, rightElfOne, rightElfTwo] = parse_assignment_numbers(line)

    (leftElfOne <= rightElfOne and leftElfTwo >= rightElfTwo)
    or
    (leftElfOne >= rightElfOne and leftElfTwo <= rightElfTwo)
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.filter(&assignments_overlap?/1)
    |> Enum.count()
  end

  defp assignments_overlap?(line) do
    [leftElfOne, leftElfTwo, rightElfOne, rightElfTwo] = parse_assignment_numbers(line)

    (leftElfOne <= rightElfTwo and rightElfOne <= leftElfTwo)
    or
    (rightElfOne <= leftElfTwo and leftElfOne <= rightElfTwo)
  end

  defp parse_assignment_numbers(line) do
    [left, right] = String.split(line, ",")
    [leftElfOne, leftElfTwo] = String.split(left, "-") |> Enum.map(&String.to_integer/1)
    [rightElfOne, rightElfTwo] = String.split(right, "-") |> Enum.map(&String.to_integer/1)

    [leftElfOne, leftElfTwo, rightElfOne, rightElfTwo]
  end
end
