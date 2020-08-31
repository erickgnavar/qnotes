defmodule Qnotes.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Qnotes.Repo,
      # Start the Telemetry supervisor
      QnotesWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Qnotes.PubSub},
      # Start the Endpoint (http/https)
      QnotesWeb.Endpoint
      # Start a worker by calling: Qnotes.Worker.start_link(arg)
      # {Qnotes.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Qnotes.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    QnotesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
