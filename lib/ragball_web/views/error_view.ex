defmodule RagballWeb.ErrorView do
  use RagballWeb, :view

  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("500.html", _assigns) do
    "Internal server error"
  end

  def render("401.json", _assigns) do
    %{errors: %{auth: ["Unauthorized"]}}
  end

  def render("422.json", %{changeset: changeset}) do
    %{errors: Ecto.Changeset.traverse_errors(changeset, &format_error/1)}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render("500.html", assigns)
  end

  defp format_error({msg, opts}), do: String.replace(msg, "%{count}", to_string(opts[:count]))
  defp format_error(msg), do: msg
end
