defmodule MyButtonApp.Redis do

  @moduledoc false
  defp binary_to_str(session) do
    str = String.codepoints(session)
    arr = Enum.map(Enum.to_list(32..126), fn(n) -> <<n>> end)
    arr = arr ++ Enum.map(Enum.to_list(128..255), fn(n) -> <<n>> end)
    Enum.reduce(str, fn (w, accumulator) -> if w in arr, do: accumulator <> w, else: accumulator end)
  end

end
