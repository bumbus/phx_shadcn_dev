defmodule PhxShadcnDevWeb.ShowcaseLive.Tooltip do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Tooltip")}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_basic(assigns) do
    ~H"""
    <.tooltip id="basic-tt">
      <.tooltip_trigger>
        <.button variant="outline">Hover me</.button>
      </.tooltip_trigger>
      <.tooltip_content>
        Add to library
      </.tooltip_content>
    </.tooltip>
    """
  end

  defp example_side_placement(assigns) do
    ~H"""
    <.tooltip :for={side <- ~w(top right bottom left)} id={"side-#{side}"}>
      <.tooltip_trigger>
        <.button variant="outline">{String.capitalize(side)}</.button>
      </.tooltip_trigger>
      <.tooltip_content side={side}>
        Tooltip on {side}
      </.tooltip_content>
    </.tooltip>
    """
  end

  defp example_custom_delays(assigns) do
    ~H"""
    <.tooltip id="slow-tt" open_delay={500}>
      <.tooltip_trigger>
        <.button variant="outline">Slow (500ms)</.button>
      </.tooltip_trigger>
      <.tooltip_content>
        I took half a second to appear
      </.tooltip_content>
    </.tooltip>

    <.tooltip id="instant-tt" open_delay={0} close_delay={0}>
      <.tooltip_trigger>
        <.button variant="outline">Instant (0ms)</.button>
      </.tooltip_trigger>
      <.tooltip_content>
        No delay at all
      </.tooltip_content>
    </.tooltip>
    """
  end

  defp example_programmatic(assigns) do
    ~H"""
    <.tooltip id="prog-tt">
      <.tooltip_trigger>
        <.button variant="outline">Target</.button>
      </.tooltip_trigger>
      <.tooltip_content>
        Programmatically controlled
      </.tooltip_content>
    </.tooltip>

    <.button variant="secondary" phx-click={show_tooltip("prog-tt")}>Show</.button>
    <.button variant="secondary" phx-click={hide_tooltip("prog-tt")}>Hide</.button>
    """
  end

  # ── Render ──────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Tooltip" storybook="/storybook/tooltip">
        A popup that displays information related to an element when the element
        receives hover or keyboard focus. Uses the Floating hook in hover mode.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Basic --%>
      <.demo_section title="Basic" code={showcase_source(:example_basic)}>
        <:description>
          Hover over the button to see the tooltip. Focus also shows it immediately.
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
          Use <.inline_code>side</.inline_code> to place the tooltip on any side of the trigger.
          The tooltip will flip if there isn't enough space.
        </:description>

        <.card>
          <.card_content class="pt-6 flex flex-wrap justify-center gap-3">
            {example_side_placement(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: Custom Delays --%>
      <.demo_section title="Custom Delays" code={showcase_source(:example_custom_delays)}>
        <:description>
          Use <.inline_code>open_delay</.inline_code> and <.inline_code>close_delay</.inline_code>
          to control timing. The first tooltip has a 500ms open delay.
        </:description>

        <.card>
          <.card_content class="pt-6 flex flex-wrap gap-3">
            {example_custom_delays(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 4: Programmatic --%>
      <.demo_section title="Programmatic" code={showcase_source(:example_programmatic)}>
        <:description>
          Use <.inline_code>show_tooltip/2</.inline_code> and <.inline_code>hide_tooltip/2</.inline_code>
          to control tooltips from other elements.
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
