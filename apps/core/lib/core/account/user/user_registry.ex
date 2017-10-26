defmodule Herps.Core.Account.UserRegistry do
  @moduledoc """
  Create an ETS table where we'll register Workers containing pre-registered user's data.
  Once a user click's the link sent to it's email, the User will be persisted to the DB.
  """
  use GenServer
  alias Herps.Core.Supervisors.UserWorkerSupervisor

  @table :user_registry

  ### Client

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def spawn_worker(%{changes: %{email: email}} = user_changeset) do
    {:ok, pid} = UserWorkerSupervisor.start_child([user_changeset])
  end
  def confirm_registration(email) do

  end

  def get_user_worker(email) do
    email
  end

  ### Server
  def init(_) do
    :ets.new(@table, [:set, :named_table, :public, read_concurrency: true,
                                                 write_concurrency: true])
    {:ok, %{}}
  end
end
