defmodule MyButtonApp.Redis do

  @moduledoc false
  def is_admin(cookies) do
    {:ok, session} = redis_session(cookies)
    str = binary_to_str(session)
    cond do
      "i:0" == str -> false
      has_admin_role(str) -> admin_info(str)
      true -> false
    end
  end

  defp redis_session(cookies) do
    id = cookies["PHPSESSID"] || "__"
    {:ok, conn} = Redix.start_link(host: "127.0.0.1", port: 6379)
    Redix.command(conn, ["GET", "app" <> id])
  end

  defp binary_to_str(nil) do
    "i:0"
  end

  defp binary_to_str(session) do
    str = String.codepoints(session)
    arr = Enum.map(Enum.to_list(32..126), fn(n) -> <<n>> end)
    arr = arr ++ Enum.map(Enum.to_list(128..255), fn(n) -> <<n>> end)
    Enum.reduce(str, fn (w, accumulator) -> if w in arr, do: accumulator <> w, else: accumulator end)
  end

  defp admin_info(str) do
    String.split(str, "|")
      |> Enum.at(1)
      |> String.split("Symfony\\Component\\Security\\Core\\Role\\Role")
      |> Enum.at(0)
      |> String.split("Entity\\User")
      |> Enum.at(1)
      |> String.split(";s:")
      |> Enum.filter(fn (line) -> line =~ "@" && line =~ "i:5"  end)
      |> Enum.at(0)
      |> String.split(";i:5;")
      |> Enum.map(fn line -> String.split(line, ";i:") |> Enum.at(0) end)
      |> Enum.map(fn line -> String.split(line, ":") |> Enum.at(1) end)
      |> Enum.map(fn line -> String.replace(line, "\"", "") end)
  end

  defp has_admin_role(str) do
    arr = String.split(str, "|")
      |> Enum.at(1)
      |> String.replace(";}_sf2_meta", ";")
      |> String.split(";")
      |> Enum.filter(fn (line) -> line =~ "ROLE_"  end)
      |> Enum.map(fn line -> String.split(line, ":") |> Enum.at(2) end)
      |> Enum.map(fn line -> String.replace(line, "\\", "") end)
      |> Enum.map(fn line -> String.replace(line, "\"", "") end)
    cond do
      "ROLE_SUPER_ADMIN" in arr -> true
      "ROLE_ADMIN" in arr -> true
      true -> false
    end
  end

end
