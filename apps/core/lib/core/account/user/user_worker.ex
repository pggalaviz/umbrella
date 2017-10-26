defmodule Herps.Core.Account.UserWorker do
  use GenServer

  @ttl 15

  ### Client

  def start_link(user_changeset) do
    GenServer.start_link(__MODULE__, user_changeset)
  end

  ### Server

  def init(user_changeset) do
    Process.send_after(self(), :timeout, @tll)
    {:ok, user_changeset}
  end

  def handle_call(:confirm_user, _from, user_changeset) do
  end

end
