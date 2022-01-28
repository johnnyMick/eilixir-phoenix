defmodule MyButtonAppWeb.CountdownLive do
  @moduledoc "Test 3 : Server Live push to browser"
  use MyButtonAppWeb, :live_view
  use Timex

  alias MyButtonApp.Countdown

  def mount(_params, _session, socket) do
    # use the connected function to check if user has connected via socket and not the initial http request event
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    time_end = Timex.shift(Timex.now(), minutes: Countdown.time_left())

    socket = assign(socket,
        time_end: time_end,
        time_left: time_left(time_end)
      )

    {:ok, socket}
  end

  def handle_info(:tick, socket) do
    time_end = socket.assigns.time_end
    socket = assign(socket, time_left: time_left(time_end))
    {:noreply, socket}
  end

  defp time_left(time_end) do
    DateTime.diff(time_end, Timex.now())
  end

  defp format_time(time) do
    # Time left : https://hexdocs.pm/timex/Timex.html#format_duration/1
    time
    |> Timex.Duration.from_seconds()
    |> Timex.format_duration(:humanized)
  end

  defp format_date(time) do
    # formats: https://hexdocs.pm/timex/Timex.Format.DateTime.Formatters.Strftime.html
    time
    |> Timex.format!("%d %B %Y", :strftime)
  end

  def render(assigns) do
    ~H"""
    <div class="bg-gray-100 max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
      <h3 class="text-lg leading-6 font-medium text-gray-900">
        Countdown till Sales Ending on <%= format_date(@time_end) %>
      </h3>
      <p class="m-4 font-semibold text-indigo-800">
        <%= if @time_left > 0 do %>
          <%= format_time(@time_left) %> left to save 20%
        <% else %>
          Expired!
        <% end %>
      </p>
    </div>
    """
  end

end
