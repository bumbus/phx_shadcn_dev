defmodule PhxShadcnDevWeb.Components.Showcase.ShowcaseHeader do
  @moduledoc """
  Shared header for showcase pages: title, optional storybook link, description.

  Also exports `storybook_link/1` for reuse in `demo_section` and elsewhere.
  """

  use Phoenix.Component

  # ── storybook_link ─────────────────────────────────────────────────

  @doc """
  A small "Storybook →" link with an external-link icon.

  ## Attributes

  - `href` (required) — the storybook URL
  - `class` — additional classes
  """
  attr :href, :string, required: true
  attr :class, :any, default: []

  def storybook_link(assigns) do
    ~H"""
    <.link
      navigate={@href}
      class={[
        "inline-flex items-center gap-1.5 text-sm text-muted-foreground hover:text-foreground transition-colors",
        @class
      ]}
    >
      Storybook
      <svg
        xmlns="http://www.w3.org/2000/svg"
        class="size-4"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      >
        <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6" />
        <polyline points="15 3 21 3 21 9" />
        <line x1="10" x2="21" y1="14" y2="3" />
      </svg>
    </.link>
    """
  end

  # ── showcase_header ────────────────────────────────────────────────

  attr :title, :string, required: true
  attr :storybook, :string, default: nil, doc: "Storybook URL — when set, shows a link"

  slot :inner_block, required: true

  def showcase_header(assigns) do
    ~H"""
    <div>
      <div class="flex items-center justify-between gap-4">
        <h1 class="text-3xl font-bold tracking-tight">{@title}</h1>
        <.storybook_link :if={@storybook} href={@storybook} />
      </div>
      <p class="mt-2 text-muted-foreground">
        {render_slot(@inner_block)}
      </p>
    </div>
    """
  end
end
