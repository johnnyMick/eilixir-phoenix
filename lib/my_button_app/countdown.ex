defmodule MyButtonApp.Countdown do
  def time_left() do
    Enum.random(4..10)
  end
end
