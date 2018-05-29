defmodule RagballWeb.ErrorView do
  use RagballWeb, :view

  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("500.html", _assigns) do
    "Internal server error"
  end

  def render("422.json", %{changeset: changeset}) do
    errors =
      changeset
      |> Ecto.Changeset.traverse_errors(fn
        {msg, opts} -> String.replace(msg, "%{count}", to_string(opts[:count]))
        msg -> msg
      end)

    %{errors: errors}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render("500.html", assigns)
  end
end
