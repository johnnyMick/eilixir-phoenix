defmodule MyButtonApp.Visitors do

  def users() do
    Enum.random(1..20)
  end

  def page_view() do
    Enum.random(1..200)
  end

  def time_spent() do
    Enum.random(1350..7300)
  end
end
