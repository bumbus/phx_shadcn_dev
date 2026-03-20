defmodule PhxShadcnDevWeb.Components.Showcase.InlineCode do
  use Phoenix.Component

  @doc """
  An inline `<code>` element with muted background styling.
  """
  slot :inner_block, required: true

  def inline_code(assigns) do
    ~H"""
    <code class="rounded bg-muted px-1 py-0.5 text-xs">{render_slot(@inner_block)}</code>
    """
  end
end
