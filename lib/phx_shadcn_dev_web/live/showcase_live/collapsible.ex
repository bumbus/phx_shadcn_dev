defmodule PhxShadcnDevWeb.ShowcaseLive.Collapsible do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Collapsible",
       # Hybrid mode state
       event_log: [],
       # Server-controlled mode state
       server_open: false
     )}
  end

  # ── Hybrid mode events ────────────────────────────────────────────────

  @impl true
  def handle_event("collapsible:change", %{"id" => "hybrid-collapsible", "action" => action}, socket) do
    entry = "#{format_time()} → #{action}"

    {:noreply,
     update(socket, :event_log, fn log ->
       Enum.take([entry | log], 10)
     end)}
  end

  # ── Server-controlled mode events ─────────────────────────────────────

  def handle_event("collapsible:change", %{"id" => "server-collapsible", "action" => action}, socket) do
    {:noreply, assign(socket, server_open: action == "open")}
  end

  # ── Push event demo ──────────────────────────────────────────────────

  def handle_event("push-open-col", _params, socket) do
    {:noreply, push_event(socket, "phx_shadcn:command", %{id: "push-collapsible", command: "open", value: "_"})}
  end

  def handle_event("push-close-col", _params, socket) do
    {:noreply, push_event(socket, "phx_shadcn:command", %{id: "push-collapsible", command: "close", value: "_"})}
  end

  def handle_event("push-toggle-col", _params, socket) do
    {:noreply, push_event(socket, "phx_shadcn:command", %{id: "push-collapsible", command: "toggle", value: "_"})}
  end

  def handle_event("toggle-server", _params, socket) do
    {:noreply, update(socket, :server_open, &(!&1))}
  end

  def handle_event("set-server-open", %{"open" => open}, socket) do
    {:noreply, assign(socket, server_open: open == "true")}
  end

  def handle_event("clear-log", _params, socket) do
    {:noreply, assign(socket, event_log: [])}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_client_only(assigns) do
    ~H"""
    <.collapsible id="client-collapsible" class="space-y-2">
      <div class="flex items-center justify-between">
        <h4 class="text-sm font-semibold">@peduarte starred 3 repositories</h4>
        <.collapsible_trigger>
          <.button variant="ghost" size="sm" class="w-9 p-0">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <rect width="20" height="5" x="2" y="4" rx="2" />
              <path d="M4 14h6" /><path d="M4 18h6" /><path d="M14 14h6" /><path d="M14 18h6" />
            </svg>
            <span class="sr-only">Toggle</span>
          </.button>
        </.collapsible_trigger>
      </div>
      <div class="rounded-md border border-border px-4 py-2 text-sm font-mono">
        @radix-ui/primitives
      </div>
      <.collapsible_content class="space-y-2">
        <div class="rounded-md border border-border px-4 py-2 text-sm font-mono">
          @radix-ui/colors
        </div>
        <div class="rounded-md border border-border px-4 py-2 text-sm font-mono">
          @stitches/react
        </div>
      </.collapsible_content>
    </.collapsible>
    """
  end

  defp example_hybrid(assigns) do
    ~H"""
    <.collapsible id="hybrid-collapsible" on_open_change="collapsible:change" class="space-y-2">
      <div class="flex items-center justify-between">
        <h4 class="text-sm font-semibold">Toggle to see events</h4>
        <.collapsible_trigger>
          <.button variant="outline" size="sm">Toggle</.button>
        </.collapsible_trigger>
      </div>
      <.collapsible_content>
        <div class="rounded-md border border-border bg-muted/50 p-4 text-sm">
          This content toggles instantly via JS. The server was notified and updated
          the event log below.
        </div>
      </.collapsible_content>
    </.collapsible>
    """
  end

  defp example_server_controlled(assigns) do
    ~H"""
    <.button size="sm" variant="outline" phx-click="set-server-open" phx-value-open="true">
      Open
    </.button>
    <.button size="sm" variant="outline" phx-click="set-server-open" phx-value-open="false">
      Close
    </.button>
    <.button size="sm" variant="default" phx-click="toggle-server">
      Toggle
    </.button>

    <.collapsible id="server-collapsible" open={@server_open} on_open_change="collapsible:change" class="space-y-2">
      <div class="flex items-center justify-between">
        <h4 class="text-sm font-semibold">Server-controlled content</h4>
        <.collapsible_trigger>
          <.button variant="ghost" size="sm">Toggle</.button>
        </.collapsible_trigger>
      </div>
      <.collapsible_content>
        <div class="rounded-md border border-border bg-muted/50 p-4 text-sm">
          The server controls whether this is visible. The
          open assign
          is currently <code class="font-mono">{inspect(@server_open)}</code>.
        </div>
      </.collapsible_content>
    </.collapsible>
    """
  end

  defp example_push_event(assigns) do
    ~H"""
    <.button size="sm" variant="outline" phx-click="push-open-col">
      Open
    </.button>
    <.button size="sm" variant="outline" phx-click="push-close-col">
      Close
    </.button>
    <.button size="sm" variant="default" phx-click="push-toggle-col">
      Toggle
    </.button>

    <.collapsible id="push-collapsible" class="space-y-2">
      <div class="flex items-center justify-between">
        <h4 class="text-sm font-semibold">Push-controlled content</h4>
        <.collapsible_trigger>
          <.button variant="ghost" size="sm">Toggle</.button>
        </.collapsible_trigger>
      </div>
      <.collapsible_content>
        <div class="rounded-md border border-border bg-muted/50 p-4 text-sm">
          Opened by the server via push_event with command "open".
        </div>
      </.collapsible_content>
    </.collapsible>
    """
  end

  # ── Render ─────────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Collapsible" storybook="/storybook/collapsible">
        An interactive component which expands/collapses a panel.
        Simpler cousin of Accordion — single boolean open/close, no items.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Client-only --%>
      <.demo_section title="Client-only" code={showcase_source(:example_client_only)}>
        <:description>No server events. Toggles purely in JavaScript.</:description>

        <.card>
          <.card_content class="pt-6">
            {example_client_only(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Hybrid --%>
      <.demo_section title="Hybrid" code={showcase_source(:example_hybrid)}>
        <:description>
          JS toggles instantly, server receives the event with
          <.inline_code>id + value + action</.inline_code> payload.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_hybrid(assigns)}
          </.card_content>
        </.card>

        <.event_log entries={@event_log} empty_message="Toggle the collapsible above to see events." />
      </.demo_section>

      <%!-- Demo 3: Server-controlled --%>
      <.demo_section title="Server-controlled" code={showcase_source(:example_server_controlled)}>
        <:description>
          The server owns the open/closed state. Use the buttons below to control it.
        </:description>

        <div class="flex flex-wrap gap-2">
          {example_server_controlled(assigns)}
        </div>

        <.state_display label="Current server state" value={"open=#{inspect(@server_open)}"} />
      </.demo_section>

      <%!-- Demo 4: Push event (server→client commands) --%>
      <.demo_section title="Push Event (Server → Client)" code={showcase_source(:example_push_event)}>
        <:description>
          The server pushes commands to a client-mode collapsible via
          <.inline_code>push_event/3</.inline_code>.
          No <.inline_code>open</.inline_code> or
          <.inline_code>on_open_change</.inline_code> needed.
        </:description>

        <div class="flex flex-wrap gap-2">
          {example_push_event(assigns)}
        </div>
      </.demo_section>
    </div>
    """
  end
end
