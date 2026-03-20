defmodule PhxShadcnDevWeb.ShowcaseLive.Slider do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Slider",
       # Hybrid mode state
       event_log: [],
       # Server-controlled slider state
       server_value: 33
     )}
  end

  # ── Hybrid mode events ────────────────────────────────────────────

  @impl true
  def handle_event(
        "slider:change",
        %{"id" => "hybrid-slider", "value" => value} = params,
        socket
      ) do
    values = params["values"]
    percentage = params["percentage"]

    entry =
      if is_list(values) && length(values) > 1 do
        "#{format_time()} → values: #{inspect(values)}, #{Float.round(percentage / 1, 1)}%"
      else
        "#{format_time()} → value: #{value}, #{Float.round(percentage / 1, 1)}%"
      end

    {:noreply,
     update(socket, :event_log, fn log ->
       Enum.take([entry | log], 10)
     end)}
  end

  # ── Server-controlled mode events ─────────────────────────────────

  def handle_event(
        "slider:change",
        %{"id" => "server-slider", "value" => value},
        socket
      ) do
    {:noreply, assign(socket, server_value: value)}
  end

  # ── Server button controls ────────────────────────────────────────

  def handle_event("set-slider", %{"val" => val}, socket) do
    {:noreply, assign(socket, server_value: String.to_integer(val))}
  end

  def handle_event("increment-slider", _params, socket) do
    new_val = min(socket.assigns.server_value + 10, 100)
    {:noreply, assign(socket, server_value: new_val)}
  end

  # ── Push event demo ──────────────────────────────────────────────

  def handle_event("push-slider", %{"val" => val}, socket) do
    {:noreply,
     push_event(socket, "phx_shadcn:command", %{
       id: "push-slider",
       command: "set",
       value: String.to_integer(val)
     })}
  end

  def handle_event("clear-log", _params, socket) do
    {:noreply, assign(socket, event_log: [])}
  end

  # ── Examples (source extracted at compile time) ───────────────────

  defp example_client_only(assigns) do
    ~H"""
    <.slider id="client-slider" default_value={33} />
    <div class="flex flex-wrap gap-2">
      <button
        class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
        onclick="PhxShadcn.set('client-slider', 0)"
      >
        0
      </button>
      <button
        class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
        onclick="PhxShadcn.set('client-slider', 25)"
      >
        25
      </button>
      <button
        class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
        onclick="PhxShadcn.set('client-slider', 50)"
      >
        50
      </button>
      <button
        class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
        onclick="PhxShadcn.set('client-slider', 75)"
      >
        75
      </button>
      <button
        class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
        onclick="PhxShadcn.set('client-slider', 100)"
      >
        100
      </button>
    </div>
    """
  end

  defp example_range(assigns) do
    ~H"""
    <.slider id="range-demo" default_value={[25, 50]} step={5} />
    """
  end

  defp example_multiple_thumbs(assigns) do
    ~H"""
    <.slider id="multi-demo" default_value={[10, 20, 70]} step={10} />
    """
  end

  defp example_step_custom_range(assigns) do
    ~H"""
    <div class="space-y-2">
      <.label>Step 10 (0-100)</.label>
      <.slider id="step-slider" default_value={50} step={10} />
    </div>
    <div class="space-y-2">
      <.label>Custom range (0-200, step 25)</.label>
      <.slider id="range-slider" default_value={100} min={0} max={200} step={25} />
    </div>
    """
  end

  defp example_vertical(assigns) do
    ~H"""
    <.slider id="vertical-slider-1" default_value={50} orientation="vertical" class="h-40" />
    <.slider id="vertical-slider-2" default_value={25} orientation="vertical" class="h-40" />
    """
  end

  defp example_disabled(assigns) do
    ~H"""
    <.slider id="disabled-slider" default_value={60} disabled />
    """
  end

  defp example_hybrid(assigns) do
    ~H"""
    <.slider id="hybrid-slider" default_value={33} on_value_change="slider:change" />
    """
  end

  defp example_server_controlled(assigns) do
    ~H"""
    <div class="flex flex-wrap gap-2 mb-3">
      <.button size="sm" variant="outline" phx-click="set-slider" phx-value-val="0">
        0
      </.button>
      <.button size="sm" variant="outline" phx-click="set-slider" phx-value-val="25">
        25
      </.button>
      <.button size="sm" variant="outline" phx-click="set-slider" phx-value-val="50">
        50
      </.button>
      <.button size="sm" variant="outline" phx-click="increment-slider">
        +10
      </.button>
      <.button size="sm" variant="outline" phx-click="set-slider" phx-value-val="100">
        100
      </.button>
    </div>

    <.card>
      <.card_content class="pt-6">
        <.slider
          id="server-slider"
          value={@server_value}
          on_value_change="slider:change"
        />
      </.card_content>
    </.card>
    """
  end

  defp example_push_event(assigns) do
    ~H"""
    <div class="flex flex-wrap gap-2">
      <.button size="sm" variant="outline" phx-click="push-slider" phx-value-val="0">0</.button>
      <.button size="sm" variant="outline" phx-click="push-slider" phx-value-val="25">25</.button>
      <.button size="sm" variant="outline" phx-click="push-slider" phx-value-val="50">50</.button>
      <.button size="sm" variant="outline" phx-click="push-slider" phx-value-val="75">75</.button>
      <.button size="sm" variant="outline" phx-click="push-slider" phx-value-val="100">100</.button>
    </div>

    <.card>
      <.card_content class="pt-6">
        <.slider id="push-slider" default_value={0} />
      </.card_content>
    </.card>
    """
  end

  # ── Render ───────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Slider" storybook="/storybook/slider">
        A draggable range input for selecting a numeric value.
        Demonstrated in all 3 state modes plus step, vertical, and disabled variants.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Client-only Slider --%>
      <.demo_section title="Client-only Slider" code={showcase_source(:example_client_only)}>
        <:description>
          No server events. Vanilla JS buttons update the slider via
          CustomEvent — zero latency. Drag or use keyboard
          (arrow keys, Home/End, Page Up/Down).
        </:description>
        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_client_only(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Range Slider --%>
      <.demo_section title="Range Slider" code={showcase_source(:example_range)}>
        <:description>
          Use a list with two values for a range slider. The filled area spans between the thumbs.
          Each thumb is independently draggable and keyboard-accessible.
        </:description>
        <.card>
          <.card_content class="pt-6">
            {example_range(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: Multiple Thumbs --%>
      <.demo_section title="Multiple Thumbs" code={showcase_source(:example_multiple_thumbs)}>
        <:description>
          Use a list with multiple values for multiple thumbs. The filled area spans from the
          minimum to the maximum thumb.
        </:description>
        <.card>
          <.card_content class="pt-6">
            {example_multiple_thumbs(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 4: Step + Custom Range --%>
      <.demo_section title="Step + Custom Range" code={showcase_source(:example_step_custom_range)}>
        <:description>
          step={10} snaps to multiples of 10.
          The second slider uses min={0} max={200}.
        </:description>
        <.card>
          <.card_content class="pt-6 space-y-6">
            {example_step_custom_range(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 5: Vertical --%>
      <.demo_section title="Vertical" code={showcase_source(:example_vertical)}>
        <:description>
          orientation="vertical" with an explicit height class.
          Two sliders side-by-side, matching the shadcn showcase.
        </:description>
        <.card>
          <.card_content class="pt-6 flex items-center justify-center gap-6">
            {example_vertical(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 6: Disabled --%>
      <.demo_section title="Disabled" code={showcase_source(:example_disabled)}>
        <:description>
          disabled prevents interaction and applies
          opacity-50.
        </:description>
        <.card>
          <.card_content class="pt-6">
            {example_disabled(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 7: Hybrid --%>
      <.demo_section title="Hybrid" code={showcase_source(:example_hybrid)}>
        <:description>
          JS updates instantly for responsiveness, then pushes the event to the server.
          The event log below updates via LiveView.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_hybrid(assigns)}
          </.card_content>
        </.card>

        <.event_log entries={@event_log} />
      </.demo_section>

      <%!-- Demo 8: Server-controlled --%>
      <.demo_section title="Server-controlled" code={showcase_source(:example_server_controlled)}>
        <:description>
          The server owns the state. Use the buttons below to control the slider externally.
        </:description>

        {example_server_controlled(assigns)}

        <.state_display label="Server value" value={@server_value} />
      </.demo_section>

      <%!-- Demo 9: Push Event --%>
      <.demo_section title="Push Event (Server → Client)" code={showcase_source(:example_push_event)}>
        <:description>
          The server pushes commands to a client-mode slider via
          push_event/3.
          The slider has no value or
          on_value_change — it's client-only,
          but the server can still command it.
        </:description>

        {example_push_event(assigns)}
      </.demo_section>
    </div>
    """
  end
end
