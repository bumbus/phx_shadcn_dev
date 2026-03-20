defmodule PhxShadcnDevWeb.ShowcaseLive.RadioGroup do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "RadioGroup",
       event_log: [],
       server_value: "comfortable"
     )}
  end

  # ── Hybrid mode events ────────────────────────────────────────────────

  @impl true
  def handle_event("radio:change", %{"id" => "hybrid-radio", "value" => value}, socket) do
    entry = "#{format_time()} → value: #{inspect(value)}"

    {:noreply,
     update(socket, :event_log, fn log ->
       Enum.take([entry | log], 10)
     end)}
  end

  # ── Server-controlled mode events ─────────────────────────────────────

  def handle_event("radio:change", %{"id" => "server-radio", "value" => value}, socket) do
    {:noreply, assign(socket, server_value: value)}
  end

  # ── Server button controls ────────────────────────────────────────────

  def handle_event("set-value", %{"val" => value}, socket) do
    {:noreply, assign(socket, server_value: value)}
  end

  # ── Push event demo ──────────────────────────────────────────────────

  def handle_event("push-select", %{"val" => value}, socket) do
    {:noreply,
     push_event(socket, "phx_shadcn:command", %{id: "push-radio", command: "select", value: value})}
  end

  def handle_event("clear-log", _params, socket) do
    {:noreply, assign(socket, event_log: [])}
  end

  def handle_event("noop", _params, socket), do: {:noreply, socket}

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_client_only(assigns) do
    ~H"""
    <.radio_group id="client-radio" default_value="comfortable">
      <div class="flex items-center space-x-2">
        <.radio_group_item value="default" id="r1" />
        <.label for="r1">Default</.label>
      </div>
      <div class="flex items-center space-x-2">
        <.radio_group_item value="comfortable" id="r2" />
        <.label for="r2">Comfortable</.label>
      </div>
      <div class="flex items-center space-x-2">
        <.radio_group_item value="compact" id="r3" />
        <.label for="r3">Compact</.label>
      </div>
    </.radio_group>
    """
  end

  defp example_horizontal(assigns) do
    ~H"""
    <.radio_group id="horizontal-radio" default_value="sm" orientation="horizontal">
      <div class="flex items-center space-x-2">
        <.radio_group_item value="sm" id="h1" />
        <.label for="h1">Small</.label>
      </div>
      <div class="flex items-center space-x-2">
        <.radio_group_item value="md" id="h2" />
        <.label for="h2">Medium</.label>
      </div>
      <div class="flex items-center space-x-2">
        <.radio_group_item value="lg" id="h3" />
        <.label for="h3">Large</.label>
      </div>
    </.radio_group>
    """
  end

  defp example_hybrid(assigns) do
    ~H"""
    <.radio_group id="hybrid-radio" on_value_change="radio:change">
      <div class="flex items-center space-x-2">
        <.radio_group_item value="light" id="hy1" />
        <.label for="hy1">Light</.label>
      </div>
      <div class="flex items-center space-x-2">
        <.radio_group_item value="dark" id="hy2" />
        <.label for="hy2">Dark</.label>
      </div>
      <div class="flex items-center space-x-2">
        <.radio_group_item value="system" id="hy3" />
        <.label for="hy3">System</.label>
      </div>
    </.radio_group>
    """
  end

  defp example_server_controlled(assigns) do
    ~H"""
    <.button size="sm" variant="outline" phx-click="set-value" phx-value-val="default">
      Default
    </.button>
    <.button size="sm" variant="outline" phx-click="set-value" phx-value-val="comfortable">
      Comfortable
    </.button>
    <.button size="sm" variant="outline" phx-click="set-value" phx-value-val="compact">
      Compact
    </.button>

    <.radio_group id="server-radio" value={@server_value} on_value_change="radio:change">
      <div class="flex items-center space-x-2">
        <.radio_group_item value="default" id="s1" />
        <.label for="s1">Default</.label>
      </div>
      <div class="flex items-center space-x-2">
        <.radio_group_item value="comfortable" id="s2" />
        <.label for="s2">Comfortable</.label>
      </div>
      <div class="flex items-center space-x-2">
        <.radio_group_item value="compact" id="s3" />
        <.label for="s3">Compact</.label>
      </div>
    </.radio_group>
    """
  end

  defp example_disabled(assigns) do
    ~H"""
    <.radio_group id="disabled-radio" default_value="option-1">
      <div class="flex items-center space-x-2">
        <.radio_group_item value="option-1" id="d1" />
        <.label for="d1">Option 1</.label>
      </div>
      <div class="flex items-center space-x-2">
        <.radio_group_item value="option-2" id="d2" disabled />
        <.label for="d2" class="opacity-50">Option 2 (disabled)</.label>
      </div>
      <div class="flex items-center space-x-2">
        <.radio_group_item value="option-3" id="d3" />
        <.label for="d3">Option 3</.label>
      </div>
    </.radio_group>
    """
  end

  defp example_form(assigns) do
    ~H"""
    <form phx-change="noop" class="space-y-4">
      <.radio_group id="form-radio" name="plan" default_value="pro">
        <div class="flex items-center space-x-2">
          <.radio_group_item value="free" id="f1" />
          <.label for="f1">Free</.label>
        </div>
        <div class="flex items-center space-x-2">
          <.radio_group_item value="pro" id="f2" />
          <.label for="f2">Pro</.label>
        </div>
        <div class="flex items-center space-x-2">
          <.radio_group_item value="enterprise" id="f3" />
          <.label for="f3">Enterprise</.label>
        </div>
      </.radio_group>
    </form>
    """
  end

  defp example_push_event(assigns) do
    ~H"""
    <.button size="sm" variant="outline" phx-click="push-select" phx-value-val="apple">
      Select Apple
    </.button>
    <.button size="sm" variant="outline" phx-click="push-select" phx-value-val="banana">
      Select Banana
    </.button>
    <.button size="sm" variant="outline" phx-click="push-select" phx-value-val="orange">
      Select Orange
    </.button>

    <.radio_group id="push-radio">
      <div class="flex items-center space-x-2">
        <.radio_group_item value="apple" id="p1" />
        <.label for="p1">Apple</.label>
      </div>
      <div class="flex items-center space-x-2">
        <.radio_group_item value="banana" id="p2" />
        <.label for="p2">Banana</.label>
      </div>
      <div class="flex items-center space-x-2">
        <.radio_group_item value="orange" id="p3" />
        <.label for="p3">Orange</.label>
      </div>
    </.radio_group>
    """
  end

  # ── Render ─────────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="RadioGroup" storybook="/storybook/radio-group">
        A set of radio buttons with keyboard navigation and single selection.
        Demonstrated in all 3 state modes.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Client-only --%>
      <.demo_section title="Client-only RadioGroup" code={showcase_source(:example_client_only)}>
        <:description>
          No server events. Selection and keyboard navigation are handled purely via JavaScript.
        </:description>
        <.card>
          <.card_content class="pt-6">
            {example_client_only(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Horizontal orientation --%>
      <.demo_section title="Horizontal Orientation" code={showcase_source(:example_horizontal)}>
        <:description>
          Use <.inline_code>orientation="horizontal"</.inline_code> for a horizontal layout.
          Arrow Left/Right navigate between items.
        </:description>
        <.card>
          <.card_content class="pt-6">
            {example_horizontal(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: Hybrid --%>
      <.demo_section title="Hybrid" code={showcase_source(:example_hybrid)}>
        <:description>
          JS selects instantly for responsiveness, then pushes the event to the server.
          The event log below updates via LiveView.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_hybrid(assigns)}
          </.card_content>
        </.card>

        <.event_log entries={@event_log} />
      </.demo_section>

      <%!-- Demo 4: Server-controlled --%>
      <.demo_section title="Server-controlled" code={showcase_source(:example_server_controlled)}>
        <:description>
          The server owns the state. Use the buttons below to control the selection externally.
        </:description>

        <div class="flex flex-wrap gap-2">
          {example_server_controlled(assigns)}
        </div>

        <.state_display label="Server value" value={inspect(@server_value)} />
      </.demo_section>

      <%!-- Demo 5: Disabled items --%>
      <.demo_section title="Disabled Items" code={showcase_source(:example_disabled)}>
        <:description>
          Individual items can be disabled. Keyboard navigation skips disabled items.
        </:description>
        <.card>
          <.card_content class="pt-6">
            {example_disabled(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 6: Form integration --%>
      <.demo_section title="Form Integration" code={showcase_source(:example_form)}>
        <:description>
          With a <.inline_code>name</.inline_code> attr, RadioGroup syncs a hidden input
          for native form submission. Works with <.inline_code>phx-change</.inline_code>
          and <.inline_code>phx-submit</.inline_code>.
        </:description>
        <.card>
          <.card_content class="pt-6">
            {example_form(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 7: Push event --%>
      <.demo_section title="Push Event (Server → Client)" code={showcase_source(:example_push_event)}>
        <:description>
          The server pushes commands to a client-mode radio group via
          <.inline_code>push_event/3</.inline_code>.
        </:description>

        <div class="flex flex-wrap gap-2">
          {example_push_event(assigns)}
        </div>
      </.demo_section>
    </div>
    """
  end
end
