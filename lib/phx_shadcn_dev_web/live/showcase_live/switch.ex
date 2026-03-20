defmodule PhxShadcnDevWeb.ShowcaseLive.Switch do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Switch",
       # Hybrid mode state
       event_log: [],
       # Server-controlled switch state
       server_checked: false
     )}
  end

  # ── Hybrid mode events ────────────────────────────────────────────────

  @impl true
  def handle_event("switch:change", %{"id" => "hybrid-switch", "checked" => checked}, socket) do
    entry = "#{format_time()} → checked: #{inspect(checked)}"

    {:noreply,
     update(socket, :event_log, fn log ->
       Enum.take([entry | log], 10)
     end)}
  end

  # ── Server-controlled mode events ─────────────────────────────────────

  def handle_event("switch:change", %{"id" => "server-switch", "checked" => checked}, socket) do
    {:noreply, assign(socket, server_checked: checked)}
  end

  # ── Server button controls ────────────────────────────────────────────

  def handle_event("set-checked", %{"checked" => "true"}, socket) do
    {:noreply, assign(socket, server_checked: true)}
  end

  def handle_event("set-checked", %{"checked" => "false"}, socket) do
    {:noreply, assign(socket, server_checked: false)}
  end

  # ── Push event demo ──────────────────────────────────────────────────

  def handle_event("push-check", _params, socket) do
    {:noreply,
     push_event(socket, "phx_shadcn:command", %{id: "push-switch", command: "check"})}
  end

  def handle_event("push-uncheck", _params, socket) do
    {:noreply,
     push_event(socket, "phx_shadcn:command", %{id: "push-switch", command: "uncheck"})}
  end

  def handle_event("push-toggle", _params, socket) do
    {:noreply,
     push_event(socket, "phx_shadcn:command", %{id: "push-switch", command: "toggle"})}
  end

  def handle_event("clear-log", _params, socket) do
    {:noreply, assign(socket, event_log: [])}
  end

  # ── Examples (source extracted at compile time) ───────────────────────

  defp example_client_only(assigns) do
    ~H"""
    <div class="flex items-center gap-3">
      <.switch id="client-switch" />
      <.label for="client-switch">Airplane Mode</.label>
    </div>
    <div class="flex items-center gap-3">
      <.switch id="client-checked" default_checked />
      <.label for="client-checked">Notifications (starts on)</.label>
    </div>
    """
  end

  defp example_sizes(assigns) do
    ~H"""
    <div class="flex items-center gap-3">
      <.switch id="size-default" />
      <.label for="size-default">Default</.label>
    </div>
    <div class="flex items-center gap-3">
      <.switch id="size-sm" size="sm" />
      <.label for="size-sm">Small</.label>
    </div>
    """
  end

  defp example_hybrid(assigns) do
    ~H"""
    <div class="flex items-center gap-3">
      <.switch id="hybrid-switch" on_checked_change="switch:change" />
      <.label for="hybrid-switch">Dark Mode</.label>
    </div>
    """
  end

  defp example_server_controlled(assigns) do
    ~H"""
    <div class="flex flex-wrap gap-2 mb-3">
      <.button size="sm" variant="outline" phx-click="set-checked" phx-value-checked="true">
        Check
      </.button>
      <.button size="sm" variant="outline" phx-click="set-checked" phx-value-checked="false">
        Uncheck
      </.button>
    </div>

    <.card>
      <.card_content class="pt-6">
        <div class="flex items-center gap-3">
          <.switch id="server-switch" checked={@server_checked} on_checked_change="switch:change" />
          <.label for="server-switch">Server Switch</.label>
        </div>
      </.card_content>
    </.card>
    """
  end

  defp example_push_event(assigns) do
    ~H"""
    <div class="flex flex-wrap gap-2">
      <.button size="sm" variant="outline" phx-click="push-check">Check</.button>
      <.button size="sm" variant="outline" phx-click="push-uncheck">Uncheck</.button>
      <.button size="sm" variant="outline" phx-click="push-toggle">Toggle</.button>
    </div>

    <.card>
      <.card_content class="pt-6">
        <div class="flex items-center gap-3">
          <.switch id="push-switch" />
          <.label for="push-switch">Push-controlled</.label>
        </div>
      </.card_content>
    </.card>
    """
  end

  # ── Render ─────────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Switch" storybook="/storybook/switch">
        A control that allows the user to toggle between checked and unchecked.
        Demonstrated in all 3 state modes.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Client-only Switch --%>
      <.demo_section title="Client-only Switch" code={showcase_source(:example_client_only)}>
        <:description>
          No server events. The switch flips purely via JavaScript — zero latency.
        </:description>
        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_client_only(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Sizes --%>
      <.demo_section title="Sizes" code={showcase_source(:example_sizes)}>
        <:description>
          Two sizes: default and sm.
        </:description>
        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_sizes(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: Hybrid --%>
      <.demo_section title="Hybrid" code={showcase_source(:example_hybrid)}>
        <:description>
          JS toggles instantly for responsiveness, then pushes the event to the server.
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
          The server owns the state. Use the buttons below to control the switch externally.
        </:description>

        {example_server_controlled(assigns)}

        <.state_display label="Server checked" value={inspect(@server_checked)} />
      </.demo_section>

      <%!-- Demo 5: Push event --%>
      <.demo_section title="Push Event (Server → Client)" code={showcase_source(:example_push_event)}>
        <:description>
          The server pushes commands to a client-mode switch via
          push_event/3.
          The switch has no checked or
          on_checked_change — it's client-only,
          but the server can still command it.
        </:description>

        {example_push_event(assigns)}
      </.demo_section>
    </div>
    """
  end
end
