defmodule MyButtonAppWeb.TicketsLive do
  @moduledoc "Test 2 for Live view page"
  use MyButtonAppWeb, :live_view

  alias MyButtonApp.Ticketing
  import Number.Currency

  def mount(_params, _session, socket) do
    numb = 2
    socket = assign(socket, number: numb, total: Ticketing.calc_price(numb))
    {:ok, socket}
  end

  def handle_event("change", %{"number" => numb}, socket) do
    numb = String.to_integer(numb)
    socket = assign(socket, number: numb, total: Ticketing.calc_price(numb))
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="bg-gray-100 max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
      <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
        Your <span class="text-red-600"><%= @number %></span>
        Tickets will cost you <span class="text-red-600"><%= number_to_currency(@total) %></span>
      </h2>
      <div class="py-6">
        <form phx-change="change">
          <input class="form-range w-full"
           type="range" min="2" max="32" name="number" value="2" />
        </form>
      </div>
    </div>
    """
  end

end
