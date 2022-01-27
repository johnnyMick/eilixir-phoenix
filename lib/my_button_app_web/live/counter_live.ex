defmodule MyButtonAppWeb.CounterLive do
  @moduledoc "Test Live view page"
  use MyButtonAppWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :counter, Enum.random(1..10_000))
    {:ok, socket}
  end

  def handle_event("random", _, socket) do
    counter = Enum.random(1..10_000)
    socket = assign(socket, :counter, counter)
    {:noreply, socket}
  end

  def handle_event("min", _, socket) do
    socket = assign(socket, :counter, 0)
    {:noreply, socket}
  end

  def handle_event("max", _, socket) do
    socket = assign(socket, :counter, 1000)
    {:noreply, socket}
  end

  def handle_event("remove", _, socket) do
    counter = socket.assigns.counter - 10
    socket = assign(socket, :counter, counter)
    {:noreply, socket}
  end

  def handle_event("add", _, socket) do
    # we can use the update function that take an anonymous function &(), then with the first agr &1 we add +10
    socket = update(socket, :counter, &(&1 + 10))
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
      <div class="bg-gray-100 max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
        <h3 class="text-lg leading-6 font-medium text-gray-900">
          Our Big Counter is :
        </h3>
        <dl class="mt-5 grid grid-cols-1 gap-5 sm:grid-cols-3">
          <div class="px-4 py-5 bg-white shadow rounded-lg overflow-hidden sm:p-6">
            <dt class="text-sm font-medium text-gray-500 truncate">
              Current Value
            </dt>
            <dd class="mt-1 text-3xl font-semibold text-gray-900">
              <%= @counter %>
            </dd>
            <dd class="mt-1 text-3xl font-semibold text-gray-900">
              <button type="button" phx-click="random" class="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs font-medium rounded shadow-sm text-white bg-red-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                Random Value
              </button>
            </dd>
          </div>
          <div class="px-4 py-5 bg-white shadow rounded-lg overflow-hidden sm:p-6">
            <dt class="text-sm font-medium text-gray-500 truncate">
              <button type="button" phx-click="min" class="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs font-medium rounded shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                set Counter to 0
              </button>
            </dt>
            <dd class="mt-1 text-3xl font-semibold text-gray-900">
              <button type="button" phx-click="remove" class="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs font-medium rounded text-indigo-700 bg-indigo-100 hover:bg-indigo-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                remove -10 from counter
              </button>
            </dd>
          </div>
          <div class="px-4 py-5 bg-white shadow rounded-lg overflow-hidden sm:p-6">
            <dt class="text-sm font-medium text-gray-500 truncate">
              <button type="button" phx-click="max" class="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs font-medium rounded shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
              set Counter to 1000
              </button>
            </dt>
            <dd class="mt-1 text-3xl font-semibold text-gray-900">
              <button type="button" phx-click="add" class="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs font-medium rounded text-indigo-700 bg-indigo-100 hover:bg-indigo-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                add +10 to the counter
              </button>
            </dd>
          </div>
        </dl>
      </div>
    """
  end

end
