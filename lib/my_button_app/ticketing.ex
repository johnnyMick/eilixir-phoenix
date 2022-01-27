defmodule MyButtonApp.Ticketing do
  def calc_price(numb) do
    if numb <= 10 do
      numb * 111
    else
      numb * 100
    end
  end
end
