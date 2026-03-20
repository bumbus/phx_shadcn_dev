defmodule PhxShadcnDevWeb.ShowcaseLive.HoverCard do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "HoverCard")}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_basic(assigns) do
    ~H"""
    <.hover_card id="basic-hc">
      <.hover_card_trigger>
        <a href="#" class="font-medium text-primary underline underline-offset-4">
          @shadcn
        </a>
      </.hover_card_trigger>
      <.hover_card_content>
        <div class="flex justify-between space-x-4">
          <.avatar class="size-10">
            <.avatar_fallback>SC</.avatar_fallback>
          </.avatar>
          <div class="space-y-1">
            <h4 class="text-sm font-semibold">@shadcn</h4>
            <p class="text-sm">
              The creator of shadcn/ui. Building beautiful component libraries.
            </p>
            <div class="flex items-center pt-2">
              <.icon name="hero-calendar-days-micro" class="mr-2 size-4 opacity-70" />
              <span class="text-xs text-muted-foreground">Joined December 2021</span>
            </div>
          </div>
        </div>
      </.hover_card_content>
    </.hover_card>
    """
  end

  defp example_side_placement(assigns) do
    ~H"""
    <.hover_card :for={side <- ~w(top right bottom left)} id={"side-#{side}-hc"}>
      <.hover_card_trigger>
        <a href="#" class="font-medium text-primary underline underline-offset-4">
          {String.capitalize(side)}
        </a>
      </.hover_card_trigger>
      <.hover_card_content side={side}>
        <p class="text-sm">Card on the <strong>{side}</strong> side.</p>
      </.hover_card_content>
    </.hover_card>
    """
  end

  defp example_custom_delays(assigns) do
    ~H"""
    <.hover_card id="fast-hc" open_delay={50} close_delay={100}>
      <.hover_card_trigger>
        <a href="#" class="font-medium text-primary underline underline-offset-4">
          Fast (50ms)
        </a>
      </.hover_card_trigger>
      <.hover_card_content>
        <p class="text-sm">I appear quickly!</p>
      </.hover_card_content>
    </.hover_card>

    <.hover_card id="slow-hc" open_delay={800} close_delay={500}>
      <.hover_card_trigger>
        <a href="#" class="font-medium text-primary underline underline-offset-4">
          Slow (800ms)
        </a>
      </.hover_card_trigger>
      <.hover_card_content>
        <p class="text-sm">I take a while to show up.</p>
      </.hover_card_content>
    </.hover_card>
    """
  end

  defp example_programmatic(assigns) do
    ~H"""
    <.hover_card id="prog-hc">
      <.hover_card_trigger>
        <a href="#" class="font-medium text-primary underline underline-offset-4">
          @target
        </a>
      </.hover_card_trigger>
      <.hover_card_content>
        <p class="text-sm">Programmatically controlled hover card.</p>
      </.hover_card_content>
    </.hover_card>

    <.button variant="secondary" phx-click={show_hover_card("prog-hc")}>Show</.button>
    <.button variant="secondary" phx-click={hide_hover_card("prog-hc")}>Hide</.button>
    """
  end

  # ── Render ──────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="HoverCard" storybook="/storybook/hover_card">
        A card that appears on hover. Like Tooltip's trigger behavior with Popover's
        visual style. Content stays open while hovering it.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Basic --%>
      <.demo_section title="Basic" code={showcase_source(:example_basic)}>
        <:description>
          Hover over the link to see a user profile card.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_basic(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Side Placement --%>
      <.demo_section title="Side Placement" code={showcase_source(:example_side_placement)}>
        <:description>
          Use <.inline_code>side</.inline_code> to place the hover card on any side of the trigger.
          The card will flip if there isn't enough space.
        </:description>

        <.card>
          <.card_content class="pt-6 flex flex-wrap justify-center gap-6">
            {example_side_placement(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: Custom Delays --%>
      <.demo_section title="Custom Delays" code={showcase_source(:example_custom_delays)}>
        <:description>
          Use <.inline_code>open_delay</.inline_code> and <.inline_code>close_delay</.inline_code>
          to control timing. Compare fast (50/100ms) vs slow (800/500ms).
        </:description>

        <.card>
          <.card_content class="pt-6 flex flex-wrap gap-6">
            {example_custom_delays(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 4: Programmatic --%>
      <.demo_section title="Programmatic" code={showcase_source(:example_programmatic)}>
        <:description>
          Use <.inline_code>show_hover_card/2</.inline_code> and <.inline_code>hide_hover_card/2</.inline_code>
          to control hover cards from other elements.
        </:description>

        <.card>
          <.card_content class="pt-6 flex flex-wrap items-center gap-3">
            {example_programmatic(assigns)}
          </.card_content>
        </.card>
      </.demo_section>
    </div>
    """
  end
end
