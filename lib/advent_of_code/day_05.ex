defmodule AdventOfCode.Day05 do
  def part1(args) do
    [cargo, instructions] = args |> String.split("\n\n")
    parsed_cargo = parse_cargo(cargo)
    parsed_instructions = parse_instructions(instructions)

    move_cargo(parsed_cargo, parsed_instructions) |> Enum.map(fn x -> hd(x) end) |> Enum.join()
  end

  defp parse_cargo(cargo) do
    cargo
    |> String.split("\n")
    |> Enum.map(fn x ->
      x
      |> String.split("")
      |> Enum.drop(2)
      |> Enum.take_every(4)
    end)
    |> Enum.drop(-1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn x -> Enum.reject(x, &(&1 == " ")) end)
  end

  defp parse_instructions(instructions) do
    instructions
    |> String.split("\n", trim: true)
    |> Enum.map(
      &(String.replace(&1, ~r/move|from|to /, "")
        |> String.split(" ", trim: true))
    )
  end

  defp move_cargo(cargo, [instruction | restInstructions] = instructions)
       when length(instructions) > 1 do
    {count, from, to} = parse_instruction(instruction)
    move(cargo, from, to, count) |> move_cargo(restInstructions)
  end

  defp move_cargo(cargo, [instruction]) do
      {count, from, to} = parse_instruction(instruction)
      move(cargo, from, to, count)
  end

  defp parse_instruction(instruction) do
    [count, from, to] = instruction
    intCount = String.to_integer(count)
    fromIndex = String.to_integer(from) - 1
    toIndex = String.to_integer(to) - 1
    {intCount, fromIndex, toIndex}
  end

  defp move(cargo, from, to, count) when count > 0 do
    [top | restFrom] = Enum.at(cargo, from)
    newTo = [top | Enum.at(cargo, to)]

    cargo
    |> List.replace_at(from, restFrom)
    |> List.replace_at(to, newTo)
    |> move(from, to, count - 1)
  end

  defp move(cargo, _from, _to, 0) do
    cargo
  end

  def part2(args) do
    [cargo, instructions] = args |> String.split("\n\n")
    parsed_cargo = parse_cargo(cargo)
    parsed_instructions = parse_instructions(instructions)

    move_cargo_2(parsed_cargo, parsed_instructions) |> Enum.map(fn x -> hd(x) end) |> Enum.join()
  end

  defp move_cargo_2(cargo, [instruction | restInstructions] = instructions)
       when length(instructions) > 1 do
    {count, from, to} = parse_instruction(instruction)
    list_one = Enum.at(cargo, from)
    listTwo = Enum.at(cargo, to)

    top = Enum.take(Enum.at(cargo, from), count)
    restFrom = Enum.drop(list_one, count)
    newTo = top ++ listTwo

    cargo
    |> List.replace_at(from, restFrom)
    |> List.replace_at(to, newTo)
    |> move_cargo_2(restInstructions)
  end

  defp move_cargo_2(cargo, [instruction]) do
    {count, from, to} = parse_instruction(instruction)
    list_one = Enum.at(cargo, from)
    listTwo = Enum.at(cargo, to)

    top = Enum.take(Enum.at(cargo, from), count)
    restFrom = Enum.drop(list_one, count)
    newTo = top ++ listTwo

    cargo
    |> List.replace_at(from, restFrom)
    |> List.replace_at(to, newTo)
  end
end
