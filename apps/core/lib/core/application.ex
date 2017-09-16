defmodule Herps.Core.Application do
  @moduledoc """
  The Herps Application Service.

  The herps system business domain lives in this application.

  Exposes API to clients such as the `HerpsWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Herps.Core.Repo, []),
    ], strategy: :one_for_one, name: Herps.Supervisor)
  end
end
