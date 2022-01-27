defmodule MyButtonAppWeb.VisitorsLive do
  @moduledoc "Test 3 : Server Live push to browser"
  use MyButtonAppWeb, :live_view

  alias MyButtonApp.Visitors

  def mount(_params, _session, socket) do
    # use the connected function to check if user has connected via socket and not the initial http request event
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end
    socket = assign_status(socket)
    {:ok, socket}
  end

  def handle_event("refresh", _, socket) do
    socket = assign_status(socket)
    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    socket = assign_status(socket)
    {:noreply, socket}
  end

  defp assign_status(socket) do
    assign(socket,
      visitors: Visitors.users(),
      page_view: Visitors.page_view(),
      time_spent: Visitors.time_spent()
    )
  end

  def render(assigns) do
    ~H"""
    <div class="bg-gray-100 max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
      <h3 class="text-lg leading-6 font-medium text-gray-900">
        Live Stats
      </h3>
      <dl class="mt-5 grid grid-cols-1 gap-5 sm:grid-cols-3">
        <div class="px-4 py-5 bg-white shadow rounded-lg overflow-hidden sm:p-6">
          <dt class="text-sm font-medium text-gray-500 truncate">
            Total Visitors
          </dt>
          <dd class="mt-1 text-3xl font-semibold text-gray-900">
            <%= @visitors %>
          </dd>
        </div>

        <div class="px-4 py-5 bg-white shadow rounded-lg overflow-hidden sm:p-6">
          <dt class="text-sm font-medium text-gray-500 truncate">
            Page Viewed
          </dt>
          <dd class="mt-1 text-3xl font-semibold text-gray-900">
            <%= @page_view %>
          </dd>
        </div>

        <div class="px-4 py-5 bg-white shadow rounded-lg overflow-hidden sm:p-6">
          <dt class="text-sm font-medium text-gray-500 truncate">
            Avg. Time spent
          </dt>
          <dd class="mt-1 text-3xl font-semibold text-gray-900">
            <%= @time_spent %> seconds
          </dd>
        </div>
      </dl>
      <div class="container py-12">
        <button phx-click="refresh" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-full shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          Refresh Stats
        </button>
      </div>
    </div>
    """
  end

end
