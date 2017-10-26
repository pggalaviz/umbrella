defmodule Herps.Core.Schema do
  @moduledoc """
    This is the main Schema for models.
    Will use Timex.Ecto timestamps instead of Ecto timestamps.
    All primary_keys will be UUID instead of an autoincrementing integer.
  """
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      use Timex.Ecto.Timestamps

      import Ecto.Changeset

      alias Herps.Core.Repo
      alias Timex.Ecto.DateTime

      @primary_key {:id, Ecto.UUID, autogenerate: true}
      @foreign_key_type Ecto.UUID
    end
  end
end
