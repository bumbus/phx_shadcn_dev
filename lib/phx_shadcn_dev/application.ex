defmodule PhxShadcnDev.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhxShadcnDevWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:phx_shadcn_dev, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhxShadcnDev.PubSub},
      # Start a worker by calling: PhxShadcnDev.Worker.start_link(arg)
      # {PhxShadcnDev.Worker, arg},
      # Start to serve requests, typically the last entry
      PhxShadcnDevWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxShadcnDev.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxShadcnDevWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
