defmodule RumblWeb.VideoHTML do
  use RumblWeb, :html
  alias Rumbl.Multimedia.Category

  embed_templates "video_html/*"

  @doc """
  Renders a video form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :categories, Category, required: true

  def video_form(assigns)

  def category_select_options(categories) do
    options = for category <- categories, do: {category.name, category.id}
    IO.inspect(options, label: "options")
    options
  end
end
