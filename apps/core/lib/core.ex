defmodule Herps.Core do
  @moduledoc """
  Herps.Core keep the contexts that define the domain
  and business logic.

  Contexts are also responsible for managing data, regardless
  if it comes from the database, an external API or others.
  """
  def core_status do
    "Core app is up and running!"
  end
end
