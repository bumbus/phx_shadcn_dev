defmodule PhxShadcnDevWeb.ShowcaseLive.Toggle do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Toggle",
       # Hybrid mode state
       event_log: [],
       # Server-controlled toggle state
       server_pressed: false,
       # Server-controlled toggle group state (empty string = nothing selected)
       server_group_value: ""
     )}
  end

  # ── Hybrid mode events ────────────────────────────────────────────────

  @impl true
  def handle_event("toggle:change", %{"id" => "hybrid-toggle"} = params, socket) do
    entry = "#{format_time()} → pressed: #{inspect(params["pressed"])}"

    {:noreply,
     update(socket, :event_log, fn log ->
       Enum.take([entry | log], 10)
     end)}
  end

  def handle_event("toggle-group:change", %{"id" => "hybrid-group"} = params, socket) do
    entry = "#{format_time()} → #{params["action"]}: #{inspect(params["value"])}"

    {:noreply,
     update(socket, :event_log, fn log ->
       Enum.take([entry | log], 10)
     end)}
  end

  # ── Server-controlled mode events ─────────────────────────────────────

  def handle_event("toggle:change", %{"id" => "server-toggle", "pressed" => pressed}, socket) do
    {:noreply, assign(socket, server_pressed: pressed)}
  end

  def handle_event(
        "toggle-group:change",
        %{"id" => "server-group", "value" => value},
        socket
      ) do
    new_value = if is_binary(value), do: value, else: ""
    {:noreply, assign(socket, server_group_value: new_value)}
  end

  # ── Server button controls ────────────────────────────────────────────

  def handle_event("set-pressed", %{"pressed" => "true"}, socket) do
    {:noreply, assign(socket, server_pressed: true)}
  end

  def handle_event("set-pressed", %{"pressed" => "false"}, socket) do
    {:noreply, assign(socket, server_pressed: false)}
  end

  def handle_event("set-group-value", %{"item" => value}, socket) do
    {:noreply, assign(socket, server_group_value: value)}
  end

  # ── Push event demo ──────────────────────────────────────────────────

  def handle_event("push-press", _params, socket) do
    {:noreply,
     push_event(socket, "phx_shadcn:command", %{id: "push-toggle", command: "press"})}
  end

  def handle_event("push-unpress", _params, socket) do
    {:noreply,
     push_event(socket, "phx_shadcn:command", %{id: "push-toggle", command: "unpress"})}
  end

  def handle_event("push-toggle", _params, socket) do
    {:noreply,
     push_event(socket, "phx_shadcn:command", %{id: "push-toggle", command: "toggle"})}
  end

  def handle_event("clear-log", _params, socket) do
    {:noreply, assign(socket, event_log: [])}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_client_only(assigns) do
    ~H"""
    <.toggle id="client-bold">
      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 4h8a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/><path d="M6 12h9a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/></svg>
    </.toggle>
    <.toggle id="client-italic" variant="outline">
      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="19" x2="10" y1="4" y2="4"/><line x1="14" x2="5" y1="20" y2="20"/><line x1="15" x2="9" y1="4" y2="20"/></svg>
    </.toggle>
    <.toggle id="client-pressed" default_pressed>
      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 4v6a6 6 0 0 0 12 0V4"/><line x1="4" x2="20" y1="20" y2="20"/></svg>
    </.toggle>
    """
  end

  defp example_client_toggle_group(assigns) do
    ~H"""
    <div>
      <p class="mb-2 text-sm font-medium">Single (alignment)</p>
      <.toggle_group id="client-align" type="single" default_value="center">
        <.toggle_group_item value="left">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" x2="3" y1="6" y2="6"/><line x1="15" x2="3" y1="12" y2="12"/><line x1="17" x2="3" y1="18" y2="18"/></svg>
        </.toggle_group_item>
        <.toggle_group_item value="center">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" x2="3" y1="6" y2="6"/><line x1="17" x2="7" y1="12" y2="12"/><line x1="19" x2="5" y1="18" y2="18"/></svg>
        </.toggle_group_item>
        <.toggle_group_item value="right">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" x2="3" y1="6" y2="6"/><line x1="21" x2="9" y1="12" y2="12"/><line x1="21" x2="7" y1="18" y2="18"/></svg>
        </.toggle_group_item>
      </.toggle_group>
    </div>
    <div>
      <p class="mb-2 text-sm font-medium">Multiple (text formatting)</p>
      <.toggle_group id="client-format" type="multiple">
        <.toggle_group_item value="bold">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 4h8a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/><path d="M6 12h9a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/></svg>
        </.toggle_group_item>
        <.toggle_group_item value="italic">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="19" x2="10" y1="4" y2="4"/><line x1="14" x2="5" y1="20" y2="20"/><line x1="15" x2="9" y1="4" y2="20"/></svg>
        </.toggle_group_item>
        <.toggle_group_item value="underline">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 4v6a6 6 0 0 0 12 0V4"/><line x1="4" x2="20" y1="20" y2="20"/></svg>
        </.toggle_group_item>
      </.toggle_group>
    </div>
    <div>
      <p class="mb-2 text-sm font-medium">Outline variant (spacing=0)</p>
      <.toggle_group id="client-outline" type="single" variant="outline">
        <.toggle_group_item value="left" variant="outline">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" x2="3" y1="6" y2="6"/><line x1="15" x2="3" y1="12" y2="12"/><line x1="17" x2="3" y1="18" y2="18"/></svg>
        </.toggle_group_item>
        <.toggle_group_item value="center" variant="outline">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" x2="3" y1="6" y2="6"/><line x1="17" x2="7" y1="12" y2="12"/><line x1="19" x2="5" y1="18" y2="18"/></svg>
        </.toggle_group_item>
        <.toggle_group_item value="right" variant="outline">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" x2="3" y1="6" y2="6"/><line x1="21" x2="9" y1="12" y2="12"/><line x1="21" x2="7" y1="18" y2="18"/></svg>
        </.toggle_group_item>
      </.toggle_group>
    </div>
    """
  end

  defp example_hybrid(assigns) do
    ~H"""
    <div>
      <p class="mb-2 text-sm font-medium">Toggle</p>
      <.toggle id="hybrid-toggle" on_pressed_change="toggle:change">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 4h8a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/><path d="M6 12h9a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/></svg>
      </.toggle>
    </div>
    <div>
      <p class="mb-2 text-sm font-medium">ToggleGroup</p>
      <.toggle_group id="hybrid-group" type="multiple" on_value_change="toggle-group:change">
        <.toggle_group_item value="bold">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 4h8a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/><path d="M6 12h9a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/></svg>
        </.toggle_group_item>
        <.toggle_group_item value="italic">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="19" x2="10" y1="4" y2="4"/><line x1="14" x2="5" y1="20" y2="20"/><line x1="15" x2="9" y1="4" y2="20"/></svg>
        </.toggle_group_item>
        <.toggle_group_item value="underline">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 4v6a6 6 0 0 0 12 0V4"/><line x1="4" x2="20" y1="20" y2="20"/></svg>
        </.toggle_group_item>
      </.toggle_group>
    </div>
    """
  end

  defp example_server_controlled(assigns) do
    ~H"""
    <div>
      <p class="mb-2 text-sm font-medium">Toggle</p>
      <div class="flex flex-wrap gap-2 mb-3">
        <.button size="sm" variant="outline" phx-click="set-pressed" phx-value-pressed="true">
          Press
        </.button>
        <.button size="sm" variant="outline" phx-click="set-pressed" phx-value-pressed="false">
          Unpress
        </.button>
      </div>
      <.card>
        <.card_content class="pt-6">
          <.toggle id="server-toggle" pressed={@server_pressed} on_pressed_change="toggle:change">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 4h8a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/><path d="M6 12h9a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/></svg>
          </.toggle>
        </.card_content>
      </.card>
    </div>

    <div>
      <p class="mb-2 text-sm font-medium">ToggleGroup</p>
      <div class="flex flex-wrap gap-2 mb-3">
        <.button size="sm" variant="outline" phx-click="set-group-value" phx-value-item="left">
          Select "Left"
        </.button>
        <.button size="sm" variant="outline" phx-click="set-group-value" phx-value-item="center">
          Select "Center"
        </.button>
        <.button size="sm" variant="destructive" phx-click="set-group-value" phx-value-item="">
          Clear
        </.button>
      </div>
      <.card>
        <.card_content class="pt-6">
          <.toggle_group id="server-group" type="single" value={@server_group_value} on_value_change="toggle-group:change">
            <.toggle_group_item value="left">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" x2="3" y1="6" y2="6"/><line x1="15" x2="3" y1="12" y2="12"/><line x1="17" x2="3" y1="18" y2="18"/></svg>
            </.toggle_group_item>
            <.toggle_group_item value="center">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" x2="3" y1="6" y2="6"/><line x1="17" x2="7" y1="12" y2="12"/><line x1="19" x2="5" y1="18" y2="18"/></svg>
            </.toggle_group_item>
            <.toggle_group_item value="right">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" x2="3" y1="6" y2="6"/><line x1="21" x2="9" y1="12" y2="12"/><line x1="21" x2="7" y1="18" y2="18"/></svg>
            </.toggle_group_item>
          </.toggle_group>
        </.card_content>
      </.card>
    </div>
    """
  end

  defp example_push_event(assigns) do
    ~H"""
    <div class="flex flex-wrap gap-2">
      <.button size="sm" variant="outline" phx-click="push-press">Press</.button>
      <.button size="sm" variant="outline" phx-click="push-unpress">Unpress</.button>
      <.button size="sm" variant="outline" phx-click="push-toggle">Toggle</.button>
    </div>

    <.card>
      <.card_content class="pt-6">
        <.toggle id="push-toggle">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 4h8a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/><path d="M6 12h9a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/></svg>
        </.toggle>
      </.card_content>
    </.card>
    """
  end

  # ── Render ─────────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Toggle" storybook="/storybook/toggle">
        A two-state button that can be toggled on or off, plus ToggleGroup for managing
        single/multiple selection across a set of toggles. Demonstrated in all 3 state modes.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Client-only Toggle --%>
      <.demo_section title="Client-only Toggle" code={showcase_source(:example_client_only)}>
        <:description>
          No server events. The toggle flips purely via JavaScript — zero latency.
        </:description>
        <.card>
          <.card_content class="pt-6 flex items-center gap-4">
            {example_client_only(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Client-only ToggleGroup --%>
      <.demo_section title="Client-only ToggleGroup" code={showcase_source(:example_client_toggle_group)}>
        <:description>
          Single and multiple selection modes. No server involvement.
        </:description>
        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_client_toggle_group(assigns)}
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
          <.card_content class="pt-6 space-y-4">
            {example_hybrid(assigns)}
          </.card_content>
        </.card>

        <.event_log entries={@event_log} />
      </.demo_section>

      <%!-- Demo 4: Server-controlled --%>
      <.demo_section title="Server-controlled" code={showcase_source(:example_server_controlled)}>
        <:description>
          The server owns the state. Use the buttons below to control the toggle and group externally.
        </:description>

        <div class="space-y-4">
          {example_server_controlled(assigns)}
        </div>

        <.state_display label="Server pressed" value={inspect(@server_pressed)} />
        <.state_display label="Server group value" value={inspect(@server_group_value)} />
      </.demo_section>

      <%!-- Demo 5: Push event --%>
      <.demo_section title="Push Event (Server → Client)" code={showcase_source(:example_push_event)}>
        <:description>
          The server pushes commands to a client-mode toggle via
          push_event/3.
          The toggle has no pressed or
          on_pressed_change — it's client-only,
          but the server can still command it.
        </:description>

        {example_push_event(assigns)}
      </.demo_section>
    </div>
    """
  end
end
