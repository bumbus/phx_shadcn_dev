defmodule PhxShadcnDevWeb.ShowcaseLive.ScrollArea do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @tags ~w(
    Elixir Phoenix LiveView Tailwind Alpine Ecto Oban Bandit Plug Req
    Jason NimbleCSV Swoosh Bamboo ExUnit Credo Dialyxir Absinthe Tesla
    Flop Ash Broadway GenStage Flow Membrane Nerves Livebook Bumblebee
  )

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "ScrollArea", tags: @tags)}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_vertical_scroll(assigns) do
    ~H"""
    <.scroll_area id="tags-demo" class="h-72 w-48 rounded-md border">
      <div class="p-4">
        <h4 class="mb-4 text-sm font-medium leading-none">Tags</h4>
        <div :for={tag <- @tags}>
          <div class="text-sm py-1"><%= tag %></div>
          <.separator />
        </div>
      </div>
    </.scroll_area>
    """
  end

  defp example_horizontal_scroll(assigns) do
    ~H"""
    <.scroll_area id="horizontal-demo" scrollbars="horizontal" class="w-full rounded-md border">
      <div class="flex w-max space-x-4 p-4">
        <div
          :for={i <- 1..12}
          class="shrink-0 w-40 h-28 rounded-lg bg-muted flex items-center justify-center text-sm text-muted-foreground font-medium"
        >
          Card <%= i %>
        </div>
      </div>
    </.scroll_area>
    """
  end

  defp example_both_directions(assigns) do
    ~H"""
    <.scroll_area id="both-demo" scrollbars="both" class="h-72 w-full max-w-md rounded-md border">
      <div class="w-[700px] p-4 space-y-4">
        <div :for={row <- 1..20} class="flex space-x-4">
          <div
            :for={col <- 1..6}
            class="shrink-0 w-24 h-12 rounded bg-muted flex items-center justify-center text-xs text-muted-foreground"
          >
            R<%= row %>C<%= col %>
          </div>
        </div>
      </div>
    </.scroll_area>
    """
  end

  defp example_custom_heights(assigns) do
    ~H"""
    <div class="text-center space-y-2">
      <.label>h-32</.label>
      <.scroll_area id="height-sm" class="h-32 w-40 rounded-md border">
        <div class="p-3 space-y-2">
          <div :for={i <- 1..20} class="text-xs text-muted-foreground">
            Item <%= i %>
          </div>
        </div>
      </.scroll_area>
    </div>
    <div class="text-center space-y-2">
      <.label>h-48</.label>
      <.scroll_area id="height-md" class="h-48 w-40 rounded-md border">
        <div class="p-3 space-y-2">
          <div :for={i <- 1..20} class="text-xs text-muted-foreground">
            Item <%= i %>
          </div>
        </div>
      </.scroll_area>
    </div>
    <div class="text-center space-y-2">
      <.label>h-64</.label>
      <.scroll_area id="height-lg" class="h-64 w-40 rounded-md border">
        <div class="p-3 space-y-2">
          <div :for={i <- 1..20} class="text-xs text-muted-foreground">
            Item <%= i %>
          </div>
        </div>
      </.scroll_area>
    </div>
    """
  end

  # ── Render ──────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Scroll Area" storybook="/storybook/scroll-area">
        Augments native scroll functionality with custom, styled scrollbar overlays.
        Pure client-side — no server roundtrips.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Vertical scroll — classic tags list --%>
      <.demo_section title="Vertical Scroll" code={showcase_source(:example_vertical_scroll)}>
        <:description>
          A fixed-height container with a vertical scrollbar.
          The classic shadcn tags list demo.
        </:description>
        <.card>
          <.card_content class="pt-6 flex justify-center">
            {example_vertical_scroll(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Horizontal scroll --%>
      <.demo_section title="Horizontal Scroll" code={showcase_source(:example_horizontal_scroll)}>
        <:description>
          A row of cards that scrolls horizontally.
          Use scrollbars="horizontal".
        </:description>
        <.card>
          <.card_content class="pt-6">
            {example_horizontal_scroll(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: Both directions --%>
      <.demo_section title="Both Directions" code={showcase_source(:example_both_directions)}>
        <:description>
          Large content that overflows both axes.
          Use scrollbars="both".
        </:description>
        <.card>
          <.card_content class="pt-6">
            {example_both_directions(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 4: Custom heights --%>
      <.demo_section title="Custom Heights" code={showcase_source(:example_custom_heights)}>
        <:description>
          The component works at any size. Here are three scroll areas at different heights.
        </:description>
        <.card>
          <.card_content class="pt-6 flex flex-wrap gap-4 items-start justify-center">
            {example_custom_heights(assigns)}
          </.card_content>
        </.card>
      </.demo_section>
    </div>
    """
  end
end
