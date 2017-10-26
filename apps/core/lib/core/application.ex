defmodule Herps.Core.Application do
  @moduledoc """
  The Herps Core Application Service.

  The herps system business domain lives in this application.

  Exposes API to clients such as the `Herps.API` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the main DB Repo when the application starts
      supervisor(Herps.Core.Repo, []),
      # Supervise user's pre register workers
      supervisor(Herps.Core.Supervisors.UserWorkerSupervisor, [])

      # Start the User's pre name registration ETS.
      worker(Herps.Core.Account.UserRegistry, [])
      # Start a worker by calling:
      #     Herps.Core.Worker.start_link(arg1, arg2, arg3)
      # Then add here:
      #     worker(Herps.Core.Worker, [arg1, arg2, arg3]),
    ]

    opts = [strategy: :one_for_one, name: Herps.Core.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
