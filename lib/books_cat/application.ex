defmodule BooksCat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      BooksCat.Repo,
      # Start the Telemetry supervisor
      BooksCatWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BooksCat.PubSub},
      # Start the Endpoint (http/https)
      BooksCatWeb.Endpoint
      # Start a worker by calling: BooksCat.Worker.start_link(arg)
      # {BooksCat.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BooksCat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BooksCatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
