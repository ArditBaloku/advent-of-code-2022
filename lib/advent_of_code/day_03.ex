defmodule AdventOfCode.Day03 do
  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.reduce([], fn x, acc -> acc ++ find_common_item(x) end)
    |> Enum.reduce(0, fn x, acc -> acc + calculate_priority(x) end)
  end

  defp find_common_item(string) do
    length = String.length(string)
    first_half = String.slice(string, 0, round(length / 2)) |> String.split("", trim: true)
    second_half = String.slice(string, round(length / 2), length) |> String.split("", trim: true)

    first_half -- (first_half -- second_half) |> Enum.uniq()
  end

  defp calculate_priority(char) do
    if String.match?(char, ~r/[a-z]/) do
      <<lower::utf8>> = char
      lower - 96
    else
      <<upper::utf8>> = char
      upper - 38
    end
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.reduce([], fn x, acc -> acc ++ find_common_item_v2(x) end)
    |> Enum.reduce(0, fn x, acc -> acc + calculate_priority(x) end)
  end

  defp find_common_item_v2([one, two, three]) do
    string_one = one |> String.split("", trim: true) |> Enum.uniq()
    string_two = two |> String.split("", trim: true) |> Enum.uniq()
    string_three = three |> String.split("", trim: true) |> Enum.uniq()

    first_intersection = string_one -- (string_one -- string_two)
    second_intersection = string_two -- (string_two -- string_three)

    first_intersection -- (first_intersection -- second_intersection) |> Enum.uniq()
  end
end
