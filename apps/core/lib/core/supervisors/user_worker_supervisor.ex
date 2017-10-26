defmodule Herps.Core.Supervisors.UserWorkerSupervisor do
  use Supervisor
  alias Herps.Core.Account.UserWorker

  def start_link(_) do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def start_child(user_changeset) do
    Supervisor.start_child(__MODULE__, [user_changeset])
  end

  def init(_) do
    supervise(
      [worker(UserWorker, [])], strategy: :simple_one_for_one
    )
  end

end

Core.Account.User.Registration.new_worker(%{email: "example@example.com", name: "Example user"})
