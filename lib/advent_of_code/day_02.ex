defmodule AdventOfCode.Day02 do
  def part1(args) do
    args
    |> parse_input()
    |> Enum.reduce(0, fn x, acc -> acc + calculate_score(x) end)
  end

  defp parse_input(args) do
    args
    |> String.split("\n")
    |> Enum.filter(fn x -> x != "" end)
  end

  defp calculate_score(x) do
    [enemy, me] = String.split(x)
    calculate_shape_score(me) + calculate_victory(enemy, me)
  end

  defp calculate_shape_score(shape) do
    case shape do
      "X" -> 1
      "Y" -> 2
      "Z" -> 3
    end
  end

  defp calculate_victory(enemy, me) do
    case {enemy, me} do
      {"A", "X"} -> 3
      {"A", "Y"} -> 6
      {"A", "Z"} -> 0
      {"B", "X"} -> 0
      {"B", "Y"} -> 3
      {"B", "Z"} -> 6
      {"C", "X"} -> 6
      {"C", "Y"} -> 0
      {"C", "Z"} -> 3
      _ -> 0
    end
  end

  def part2(args) do
    args
    |> parse_input()
    |> Enum.reduce(0, fn x, acc -> acc + calculate_score_v2(x) end)
  end

  defp calculate_score_v2(x) do
    [enemy, result] = String.split(x)
    calculate_result_score(result) + calculate_shape_score_v2(enemy, result)
  end

  defp calculate_result_score(result) do
    case result do
      "X" -> 0
      "Y" -> 3
      "Z" -> 6
    end
  end

  defp calculate_shape_score_v2(enemy, result) do
    case {enemy, result} do
      {"A", "X"} -> 3
      {"A", "Y"} -> 1
      {"A", "Z"} -> 2
      {"B", "X"} -> 1
      {"B", "Y"} -> 2
      {"B", "Z"} -> 3
      {"C", "X"} -> 2
      {"C", "Y"} -> 3
      {"C", "Z"} -> 1
      _ -> 0
    end
  end
end
