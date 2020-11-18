defmodule GithubAnalytics.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      GithubAnalytics.Repo,
      # Start the Telemetry supervisor
      GithubAnalyticsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GithubAnalytics.PubSub},
      # Start the Endpoint (http/https)
      GithubAnalyticsWeb.Endpoint
      # Start a worker by calling: GithubAnalytics.Worker.start_link(arg)
      # {GithubAnalytics.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GithubAnalytics.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GithubAnalyticsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
