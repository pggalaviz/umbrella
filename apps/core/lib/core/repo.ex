defmodule Herps.Core.Repo do
  @moduledoc """
    Main Repo for the Core app.
  """
  use Ecto.Repo, otp_app: :core

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end
