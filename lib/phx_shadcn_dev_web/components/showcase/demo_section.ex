defmodule PhxShadcnDevWeb.Components.Showcase.DemoSection do
  use Phoenix.Component
  use PhxShadcn

  import PhxShadcnDevWeb.Components.Showcase.ShowcaseHeader, only: [storybook_link: 1]

  @doc """
  A titled section wrapper for showcase demos.

  Use the `:description` slot for a subtitle below the heading.
  Pass `code` (a string) to render a collapsible "View Code" block.
  Pass `storybook` (a URL string) to render a storybook link next to the title.
  """
  attr :title, :string, required: true
  attr :code, :any, default: nil
  attr :storybook, :string, default: nil

  slot :description
  slot :inner_block, required: true

  def demo_section(assigns) do
    ~H"""
    <section class="space-y-4">
      <div>
        <div class="flex flex-wrap items-center justify-between gap-x-4 gap-y-1">
          <h2 class="text-xl font-semibold">{@title}</h2>
          <.storybook_link :if={@storybook} href={@storybook} class="text-xs" />
        </div>
        <p :if={@description != []} class="text-sm text-muted-foreground">
          {render_slot(@description)}
        </p>
      </div>
      {render_slot(@inner_block)}
      <.code_block :if={@code} code={@code} title={@title} />
    </section>
    """
  end

  attr :code, :any, required: true
  attr :title, :string, required: true

  defp code_block(assigns) do
    id =
      "code-" <>
        (assigns.title
         |> String.downcase()
         |> String.replace(~r/[^a-z0-9]+/, "-")
         |> String.trim("-"))

    # Support both plain string and %{raw, html} map from ShowcaseCode
    {raw, html} =
      case assigns.code do
        %{raw: raw, html: html} -> {raw, html}
        str when is_binary(str) -> {str, nil}
      end

    assigns = assign(assigns, id: id, raw_code: raw, html_code: html)

    ~H"""
    <.collapsible id={@id}>
      <div class="flex items-center gap-2">
        <.collapsible_trigger>
          <.button variant="ghost" size="sm" class="gap-1.5 text-xs text-muted-foreground px-2">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="size-3.5"
            >
              <polyline points="16 18 22 12 16 6" />
              <polyline points="8 6 2 12 8 18" />
            </svg>
            View Code
          </.button>
        </.collapsible_trigger>
      </div>
      <.collapsible_content>
        <div class="relative mt-2 rounded-md border bg-zinc-950 dark:bg-zinc-900 group/code" data-raw-code={@raw_code}>
          <button
            type="button"
            aria-label="Copy code"
            onclick="
              let raw = this.closest('[data-raw-code]').dataset.rawCode;
              navigator.clipboard.writeText(raw);
              let copy = this.querySelector('[data-copy-icon]');
              let check = this.querySelector('[data-check-icon]');
              copy.classList.add('hidden');
              check.classList.remove('hidden');
              setTimeout(() => { copy.classList.remove('hidden'); check.classList.add('hidden'); }, 2000);
            "
            class="absolute right-2 top-2 rounded-md p-1.5 text-zinc-400 opacity-0 transition-opacity hover:bg-zinc-800 hover:text-zinc-200 group-hover/code:opacity-100"
          >
            <svg data-copy-icon xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="size-3.5">
              <rect width="14" height="14" x="8" y="8" rx="2" ry="2" /><path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2" />
            </svg>
            <svg data-check-icon xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="hidden size-3.5 text-green-400">
              <polyline points="20 6 9 17 4 12" />
            </svg>
          </button>
          <pre class="makeup-code overflow-x-auto p-4 text-sm leading-relaxed"><code class="text-zinc-100">{if @html_code, do: Phoenix.HTML.raw(@html_code), else: @raw_code}</code></pre>
        </div>
      </.collapsible_content>
    </.collapsible>
    """
  end
end
