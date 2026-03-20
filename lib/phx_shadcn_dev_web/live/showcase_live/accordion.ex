defmodule PhxShadcnDevWeb.ShowcaseLive.Accordion do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Accordion",
       # Hybrid mode state
       event_log: [],
       # Server-controlled mode state (empty string, not nil, so accordion renders in server mode)
       server_value: ""
     )}
  end

  # ── Hybrid mode events ────────────────────────────────────────────────

  @impl true
  def handle_event("accordion:change", %{"id" => "hybrid-faq"} = params, socket) do
    entry = "#{format_time()} → #{params["action"]}: #{inspect(params["value"])}"

    {:noreply,
     update(socket, :event_log, fn log ->
       Enum.take([entry | log], 10)
     end)}
  end

  # ── Server-controlled mode events ─────────────────────────────────────

  def handle_event(
        "accordion:change",
        %{"id" => "server-faq", "action" => action, "value" => value},
        socket
      ) do
    new_value = if action == "open", do: value, else: ""
    {:noreply, assign(socket, server_value: new_value)}
  end

  # ── Push event demo ──────────────────────────────────────────────────

  def handle_event("push-open", %{"item" => value}, socket) do
    {:noreply,
     push_event(socket, "phx_shadcn:command", %{id: "push-faq", command: "open", value: value})}
  end

  def handle_event("push-close", %{"item" => value}, socket) do
    {:noreply,
     push_event(socket, "phx_shadcn:command", %{id: "push-faq", command: "close", value: value})}
  end

  def handle_event("push-toggle", %{"item" => value}, socket) do
    {:noreply,
     push_event(socket, "phx_shadcn:command", %{id: "push-faq", command: "toggle", value: value})}
  end

  def handle_event("open-item", %{"item" => value}, socket) do
    {:noreply, assign(socket, server_value: value)}
  end

  def handle_event("close-all", _params, socket) do
    {:noreply, assign(socket, server_value: "")}
  end

  def handle_event("clear-log", _params, socket) do
    {:noreply, assign(socket, event_log: [])}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_client_only(assigns) do
    ~H"""
    <.accordion id="client-faq" type="single" collapsible>
      <.accordion_item value="q1">
        <.accordion_trigger>Is it accessible?</.accordion_trigger>
        <.accordion_content>
          Yes. It follows the WAI-ARIA design pattern for accordions.
        </.accordion_content>
      </.accordion_item>
      <.accordion_item value="q2">
        <.accordion_trigger>Is it styled?</.accordion_trigger>
        <.accordion_content>
          Yes. It comes with default styles that match the shadcn/ui aesthetic.
        </.accordion_content>
      </.accordion_item>
      <.accordion_item value="q3">
        <.accordion_trigger>Is it animated?</.accordion_trigger>
        <.accordion_content>
          Yes. It uses CSS animations for smooth open/close transitions.
        </.accordion_content>
      </.accordion_item>
    </.accordion>
    """
  end

  defp example_multiple(assigns) do
    ~H"""
    <.accordion id="multi-faq" type="multiple">
      <.accordion_item value="m1">
        <.accordion_trigger>Can I open multiple items?</.accordion_trigger>
        <.accordion_content>
          Yes! Unlike type="single", multiple items
          can be expanded simultaneously. Try opening all three.
        </.accordion_content>
      </.accordion_item>
      <.accordion_item value="m2">
        <.accordion_trigger>Do I need the collapsible prop?</.accordion_trigger>
        <.accordion_content>
          No. In multiple mode every item is independently togglable —
          the collapsible attr only applies to single mode.
        </.accordion_content>
      </.accordion_item>
      <.accordion_item value="m3">
        <.accordion_trigger>Does it work with server modes?</.accordion_trigger>
        <.accordion_content>
          Absolutely. You can combine type="multiple"
          with on_value_change or a server-owned value assign just like single mode.
        </.accordion_content>
      </.accordion_item>
    </.accordion>
    """
  end

  defp example_hybrid(assigns) do
    ~H"""
    <.accordion id="hybrid-faq" type="single" collapsible on_value_change="accordion:change">
      <.accordion_item value="item-1">
        <.accordion_trigger>What is hybrid mode?</.accordion_trigger>
        <.accordion_content>
          Hybrid mode gives you the best of both worlds: instant client-side toggling
          with server notification. The UI updates immediately, and the server receives
          an event it can react to.
        </.accordion_content>
      </.accordion_item>
      <.accordion_item value="item-2">
        <.accordion_trigger>When should I use it?</.accordion_trigger>
        <.accordion_content>
          Use hybrid mode when you need the server to know which items are open
          (e.g. for analytics, conditional loading) but don't want to sacrifice
          perceived speed.
        </.accordion_content>
      </.accordion_item>
      <.accordion_item value="item-3">
        <.accordion_trigger>How does it work?</.accordion_trigger>
        <.accordion_content>
          Pass on_value_change="accordion:change"
          without setting value.
          The hook toggles DOM state, then pushes the event name with an
          id + value + action payload.
        </.accordion_content>
      </.accordion_item>
    </.accordion>
    """
  end

  defp example_server_controlled(assigns) do
    ~H"""
    <.button size="sm" variant="outline" phx-click="open-item" phx-value-item="srv-1">
      Open "First"
    </.button>
    <.button size="sm" variant="outline" phx-click="open-item" phx-value-item="srv-2">
      Open "Second"
    </.button>
    <.button size="sm" variant="destructive" phx-click="close-all">
      Close All
    </.button>

    <.accordion id="server-faq" type="single" collapsible value={@server_value} on_value_change="accordion:change">
      <.accordion_item value="srv-1">
        <.accordion_trigger>First item</.accordion_trigger>
        <.accordion_content>
          This item is opened/closed by the server. Click the buttons above
          to control which item is open.
        </.accordion_content>
      </.accordion_item>
      <.accordion_item value="srv-2">
        <.accordion_trigger>Second item</.accordion_trigger>
        <.accordion_content>
          Server-controlled mode is useful when you need full authority over
          the UI state.
        </.accordion_content>
      </.accordion_item>
      <.accordion_item value="srv-3">
        <.accordion_trigger>Third item</.accordion_trigger>
        <.accordion_content>
          In this mode, the JS hook defers entirely to the server's value assign.
          Direct clicks still work — the hook sends the event and the server decides.
        </.accordion_content>
      </.accordion_item>
    </.accordion>
    """
  end

  defp example_push_event(assigns) do
    ~H"""
    <.button size="sm" variant="outline" phx-click="push-open" phx-value-item="p1">
      Open "First"
    </.button>
    <.button size="sm" variant="outline" phx-click="push-toggle" phx-value-item="p1">
      Toggle "First"
    </.button>
    <.button size="sm" variant="outline" phx-click="push-close" phx-value-item="p1">
      Close "First"
    </.button>

    <.accordion id="push-faq" type="single" collapsible>
      <.accordion_item value="p1">
        <.accordion_trigger>First item</.accordion_trigger>
        <.accordion_content>
          Opened by the server via push_event with command "open".
        </.accordion_content>
      </.accordion_item>
      <.accordion_item value="p2">
        <.accordion_trigger>Second item</.accordion_trigger>
        <.accordion_content>
          The server can open, close, or toggle any item by pushing a command.
          No re-render needed — the hook handles it client-side.
        </.accordion_content>
      </.accordion_item>
    </.accordion>
    """
  end

  # ── Render ─────────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Accordion" storybook="/storybook/accordion">
        A vertically stacked set of interactive headings that each reveal a section of content.
        Demonstrated below in all 3 state modes plus push_event commands.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Client-only --%>
      <.demo_section title="Client-only" code={showcase_source(:example_client_only)}>
        <:description>
          No server events. The accordion toggles purely via JavaScript — zero latency.
        </:description>
        <.card>
          <.card_content class="pt-6">
            {example_client_only(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Multiple --%>
      <.demo_section title="Multiple" code={showcase_source(:example_multiple)}>
        <:description>
          With <.inline_code>type="multiple"</.inline_code>, several items can be open
          at the same time. No <.inline_code>collapsible</.inline_code> attr needed —
          items toggle independently.
        </:description>
        <.card>
          <.card_content class="pt-6">
            {example_multiple(assigns)}
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
          The server owns the state. Use the buttons below to open items externally.
          The accordion reflects the server's <.inline_code>value</.inline_code> assign.
        </:description>

        <div class="flex flex-wrap gap-2">
          {example_server_controlled(assigns)}
        </div>

        <.state_display label="Current server value" value={inspect(@server_value)} />
      </.demo_section>

      <%!-- Demo 5: Push event (server→client commands) --%>
      <.demo_section title="Push Event (Server → Client)" code={showcase_source(:example_push_event)}>
        <:description>
          The server pushes commands to a client-mode accordion via
          <.inline_code>push_event/3</.inline_code>.
          The accordion has no <.inline_code>value</.inline_code> or
          <.inline_code>on_value_change</.inline_code> — it's client-only,
          but the server can still command it.
        </:description>

        <div class="flex flex-wrap gap-2">
          {example_push_event(assigns)}
        </div>
      </.demo_section>
    </div>
    """
  end
end
