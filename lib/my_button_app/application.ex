defmodule MyButtonApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      MyButtonApp.Repo,
      # Start the Telemetry supervisor
      MyButtonAppWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MyButtonApp.PubSub},
      # Start the Endpoint (http/https)
      MyButtonAppWeb.Endpoint
      # Start a worker by calling: MyButtonApp.Worker.start_link(arg)
      # {MyButtonApp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MyButtonApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MyButtonAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
