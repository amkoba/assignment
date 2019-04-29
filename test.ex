defmodule Test do


  def convert() do


	s = File.stream!("dictionary.txt")
	words = s |> Enum.map(&String.trim/1)


    no = [2,2,2,6,8,2,9] 


    number_map = %{
      2 => ["a", "b", "c"],
      3 => ["d", "e", "f"],
      4 => ["g", "h", "i"],
      5 => ["j", "k", "l"],
      6 => ["m", "n", "o"],
      7 => ["p", "q", "r", "s"],
      8 => ["t", "u", "v"],
      9 => ["w", "x", "y", "z"]
    }

    combo =
      Enum.reduce( no, [],
        fn x, acc ->
          codes = number_map[x]
          combination = if length(acc) > 0 do
            for i <- acc, j <- codes, do: [i, j];
            #          acc |> List.flatten
          else
            codes
          end
        end )

    combo = combo
            |> Enum.map(
                 fn x ->
                   List.flatten(x)
                   |> Enum.join end
               )
    res =
      combo |> Enum.reduce( [],
               fn x, acc ->
                 temp = Test.search(words, String.upcase(x))
               	 if temp, do: [x] ++ [acc], else: acc

               end )
  end



  def search(list, value), do: search(List.to_tuple(list), value, 0, length(list) - 1)
  def search(_tuple, _value, low, high) when high < low, do: false
  def search(tuple, value, low, high) do
    mid = div(low + high, 2)
    midval = elem(tuple, mid)
    cond do
      value == midval -> true
      value < midval -> search(tuple, value, low, mid - 1)
      value > midval -> search(tuple, value, mid + 1, high)

    end
  end

end

IO.inspect List.flatten Test.convert();


