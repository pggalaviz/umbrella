defmodule Herps.API.ErrorView do
  use Herps.API, :view

  # 400 status codes
  def render("400.json", assigns) when is_bitstring(assigns) do
    %{
      status: 400,
      errors: %{
        detail: assigns
      }
    }
  end
  def render("400.json", _assigns) do
    %{
      status: 400,
      errors: %{
        detail: "Bad request: An error ocurred, please try again later"
      }
    }
  end
  def render("403.json", assigns) when is_bitstring(assigns) do
    %{
      status: 403,
      errors: %{
        detail: assigns
      }
    }
  end
  def render("403.json", _assigns) do
    %{
      status: 403,
      errors: %{
        detail: "Unauthorized: You don't have the required permission(s)."
      }
    }
  end
  def render("404.json", _assigns) do
    %{
      status: 404,
      errors: %{
        detail: "Resource not found"
      }
    }
  end

  # 500 status codes
  def render("500.json", _assigns) do
    %{
      status: 500,
      errors: %{
        detail: "Internal server error"
      }
    }
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
  end
end
