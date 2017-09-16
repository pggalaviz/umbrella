defmodule Herps.API.MainView do
  use Herps.API, :view

  def render("index.json", %{message: message}) do
    %{
      status: message
    }
  end
end
