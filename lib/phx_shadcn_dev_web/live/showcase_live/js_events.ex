defmodule PhxShadcnDevWeb.ShowcaseLive.JsEvents do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @code_inbound ~s"""
  // Vanilla JS helpers (import + attach to window)
  PhxShadcn.open("my-collapsible", "_")
  PhxShadcn.press("my-toggle")
  PhxShadcn.select("my-group", "A")

  // Or use raw CustomEvents directly
  el.dispatchEvent(new CustomEvent("phx-shadcn:open", {
    detail: { value: "_" }
  }))\
  """

  @code_outbound ~s"""
  el.addEventListener("phx-shadcn:pressed", (e) => {
    console.log(e.detail) // { id: "my-toggle", pressed: true }
  })\
  """

  @code_push ~s"""
  push_event(socket, "phx_shadcn:command", %{
    id: "my-collapsible",
    command: "open",
    value: "_"
  })\
  """

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "JS Events",
       # Section 5: server-controlled toggle
       server_pressed: false,
       # Code snippets for Section 1
       code_inbound: @code_inbound,
       code_outbound: @code_outbound,
       code_push: @code_push
     )}
  end

  # ── Section 5: External JS → server-controlled toggle ──────────────

  @impl true
  def handle_event("toggle:change", %{"id" => "server-ext-toggle", "pressed" => pressed}, socket) do
    {:noreply, assign(socket, server_pressed: pressed)}
  end

  # ── Section 6: Server → Client push ────────────────────────────────

  def handle_event("push-open-all", _params, socket) do
    socket =
      socket
      |> push_event("phx_shadcn:command", %{id: "push-collapsible", command: "open", value: "_"})
      |> push_event("phx_shadcn:command", %{id: "push-toggle", command: "press"})
      |> push_event("phx_shadcn:command", %{id: "push-accordion", command: "open", value: "p1"})

    {:noreply, socket}
  end

  def handle_event("push-reset-all", _params, socket) do
    socket =
      socket
      |> push_event("phx_shadcn:command", %{id: "push-collapsible", command: "close", value: "_"})
      |> push_event("phx_shadcn:command", %{id: "push-toggle", command: "unpress"})
      |> push_event("phx_shadcn:command", %{id: "push-accordion", command: "close", value: "p1"})

    {:noreply, socket}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_cross_component(assigns) do
    ~H"""
    <div
      id="cross-component-coordinator"
      phx-hook="JsEventsCrossComponent"
      phx-update="ignore"
      data-toggle-id="cross-toggle"
      data-collapsible-id="cross-collapsible"
    >
      <.card>
        <.card_content class="pt-6 space-y-4">
          <div class="flex items-center gap-3">
            <span class="text-sm font-medium w-20">Toggle:</span>
            <.toggle id="cross-toggle">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m18 15-6-6-6 6"/></svg>
            </.toggle>
          </div>
          <div>
            <span class="text-sm font-medium">Collapsible:</span>
            <.collapsible id="cross-collapsible" class="mt-2 space-y-2">
              <.collapsible_trigger>
                <.button variant="outline" size="sm">Toggle content</.button>
              </.collapsible_trigger>
              <.collapsible_content>
                <div class="rounded-md border border-border bg-muted/50 p-4 text-sm">
                  This content is synced with the Toggle above via JS CustomEvents.
                  No server was involved in this interaction.
                </div>
              </.collapsible_content>
            </.collapsible>
          </div>
        </.card_content>
      </.card>
    </div>
    """
  end

  defp example_vanilla_js(assigns) do
    ~H"""
    <.card>
      <.card_content class="pt-6 space-y-6">
        <%!-- ToggleGroup --%>
        <div>
          <p class="mb-2 text-sm font-medium">ToggleGroup (client-only)</p>
          <.toggle_group id="vanilla-group" type="single">
            <.toggle_group_item value="A">A</.toggle_group_item>
            <.toggle_group_item value="B">B</.toggle_group_item>
            <.toggle_group_item value="C">C</.toggle_group_item>
          </.toggle_group>
          <div class="mt-2 flex flex-wrap gap-2">
            <button
              class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
              onclick="PhxShadcn.select('vanilla-group', 'A')"
            >
              Select A
            </button>
            <button
              class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
              onclick="PhxShadcn.select('vanilla-group', 'B')"
            >
              Select B
            </button>
            <button
              class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
              onclick="PhxShadcn.select('vanilla-group', 'C')"
            >
              Select C
            </button>
            <button
              class="inline-flex items-center justify-center rounded-md border border-destructive text-destructive bg-background px-3 py-1.5 text-sm font-medium hover:bg-destructive/10 cursor-pointer"
              onclick="PhxShadcn.set('vanilla-group', [])"
            >
              Clear
            </button>
          </div>
        </div>

        <.separator />

        <%!-- Accordion --%>
        <div>
          <p class="mb-2 text-sm font-medium">Accordion (client-only, collapsible)</p>
          <.accordion id="vanilla-accordion" type="single" collapsible>
            <.accordion_item value="q1">
              <.accordion_trigger>What is PhxShadcn?</.accordion_trigger>
              <.accordion_content>
                A Phoenix LiveView component library mirroring shadcn/ui.
              </.accordion_content>
            </.accordion_item>
            <.accordion_item value="q2">
              <.accordion_trigger>Does it need React?</.accordion_trigger>
              <.accordion_content>
                No. Pure LiveView + lightweight JS hooks.
              </.accordion_content>
            </.accordion_item>
            <.accordion_item value="q3">
              <.accordion_trigger>How are events structured?</.accordion_trigger>
              <.accordion_content>
                Inbound = imperative verbs, outbound = past tense. Same across all components.
              </.accordion_content>
            </.accordion_item>
          </.accordion>
          <div class="mt-2 flex flex-wrap gap-2">
            <button
              class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
              onclick="PhxShadcn.open('vanilla-accordion', 'q1')"
            >
              Open Q1
            </button>
            <button
              class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
              onclick="PhxShadcn.open('vanilla-accordion', 'q2')"
            >
              Open Q2
            </button>
            <button
              class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
              onclick="PhxShadcn.open('vanilla-accordion', 'q3')"
            >
              Open Q3
            </button>
            <button
              class="inline-flex items-center justify-center rounded-md border border-destructive text-destructive bg-background px-3 py-1.5 text-sm font-medium hover:bg-destructive/10 cursor-pointer"
              onclick="PhxShadcn.close('vanilla-accordion', 'q1'); PhxShadcn.close('vanilla-accordion', 'q2'); PhxShadcn.close('vanilla-accordion', 'q3')"
            >
              Close All
            </button>
          </div>
        </div>
      </.card_content>
    </.card>
    """
  end

  defp example_outbound_events(assigns) do
    ~H"""
    <div
      id="outbound-log-coordinator"
      phx-hook="JsEventsOutboundLog"
      phx-update="ignore"
      data-sources="log-toggle,log-collapsible,log-accordion"
      data-log-target="outbound-event-log"
    >
      <.card>
        <.card_content class="pt-6 space-y-4">
          <div class="flex items-center gap-3">
            <span class="text-sm font-medium w-20">Toggle:</span>
            <.toggle id="log-toggle">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 4h8a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/><path d="M6 12h9a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/></svg>
            </.toggle>
          </div>
          <div>
            <span class="text-sm font-medium">Collapsible:</span>
            <.collapsible id="log-collapsible" class="mt-2 space-y-2">
              <.collapsible_trigger>
                <.button variant="outline" size="sm">Toggle</.button>
              </.collapsible_trigger>
              <.collapsible_content>
                <div class="rounded-md border border-border bg-muted/50 p-4 text-sm">
                  Collapsible content. Watch the log below.
                </div>
              </.collapsible_content>
            </.collapsible>
          </div>
          <div>
            <span class="text-sm font-medium">Accordion:</span>
            <.accordion id="log-accordion" type="single" collapsible class="mt-2">
              <.accordion_item value="a1">
                <.accordion_trigger>First item</.accordion_trigger>
                <.accordion_content>Content for the first item.</.accordion_content>
              </.accordion_item>
              <.accordion_item value="a2">
                <.accordion_trigger>Second item</.accordion_trigger>
                <.accordion_content>Content for the second item.</.accordion_content>
              </.accordion_item>
            </.accordion>
          </div>
        </.card_content>
      </.card>

      <%!-- Event log (pure JS, no server) --%>
      <div class="mt-3 rounded-md border border-border bg-muted/30 p-3">
        <div class="flex items-center justify-between mb-2">
          <span class="text-xs font-semibold uppercase tracking-wider text-muted-foreground">
            Event Log (client-side)
          </span>
          <button
            class="text-xs text-muted-foreground hover:text-foreground cursor-pointer"
            onclick="document.getElementById('outbound-event-log').innerHTML = ''"
          >
            Clear
          </button>
        </div>
        <div
          id="outbound-event-log"
          class="max-h-40 overflow-y-auto text-xs font-mono text-muted-foreground"
        >
        </div>
      </div>
    </div>
    """
  end

  defp example_external_js_server(assigns) do
    ~H"""
    <.card>
      <.card_content class="pt-6 space-y-4">
        <div class="flex items-center gap-3">
          <span class="text-sm font-medium">Server Toggle:</span>
          <.toggle id="server-ext-toggle" pressed={@server_pressed} on_pressed_change="toggle:change">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 4h8a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/><path d="M6 12h9a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/></svg>
          </.toggle>
        </div>
        <.separator />
        <div>
          <p class="mb-2 text-sm font-medium text-muted-foreground">Vanilla JS buttons (drive server state)</p>
          <div class="flex flex-wrap gap-2">
            <button
              class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
              onclick="PhxShadcn.press('server-ext-toggle')"
            >
              JS: Press
            </button>
            <button
              class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
              onclick="PhxShadcn.unpress('server-ext-toggle')"
            >
              JS: Unpress
            </button>
            <button
              class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
              onclick="PhxShadcn.toggle('server-ext-toggle')"
            >
              JS: Toggle
            </button>
          </div>
        </div>
      </.card_content>
    </.card>
    """
  end

  defp example_server_push(assigns) do
    ~H"""
    <div class="flex flex-wrap gap-2">
      <.button size="sm" variant="default" phx-click="push-open-all">
        Open Everything
      </.button>
      <.button size="sm" variant="outline" phx-click="push-reset-all">
        Reset All
      </.button>
    </div>

    <.card>
      <.card_content class="pt-6 space-y-4">
        <div class="flex items-center gap-3">
          <span class="text-sm font-medium w-20">Toggle:</span>
          <.toggle id="push-toggle">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 4h8a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/><path d="M6 12h9a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"/></svg>
          </.toggle>
        </div>
        <div>
          <span class="text-sm font-medium">Collapsible:</span>
          <.collapsible id="push-collapsible" class="mt-2 space-y-2">
            <.collapsible_trigger>
              <.button variant="outline" size="sm">Toggle</.button>
            </.collapsible_trigger>
            <.collapsible_content>
              <div class="rounded-md border border-border bg-muted/50 p-4 text-sm">
                Opened by the server via <.inline_code>push_event/3</.inline_code>
                alongside the Toggle and Accordion &mdash; one server action, three components.
              </div>
            </.collapsible_content>
          </.collapsible>
        </div>
        <div>
          <span class="text-sm font-medium">Accordion:</span>
          <.accordion id="push-accordion" type="single" collapsible class="mt-2">
            <.accordion_item value="p1">
              <.accordion_trigger>Push-controlled item</.accordion_trigger>
              <.accordion_content>
                This item was opened by the server alongside the Toggle and Collapsible above.
              </.accordion_content>
            </.accordion_item>
          </.accordion>
        </div>
      </.card_content>
    </.card>
    """
  end

  # ── Render ──────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="JS Events">
        Every PhxShadcn interactive component exposes a consistent JS event API.
        Components can be controlled imperatively via vanilla JS, talk to each other
        through CustomEvents, or be commanded from the server via
        <.inline_code>push_event/3</.inline_code>. Works with Alpine, Stimulus, or
        any other JS library.
      </.showcase_header>

      <.separator />

      <%!-- Section 1: How It Works --%>
      <.demo_section title="How It Works">
        <:description>
          Three communication channels are available on every interactive component.
        </:description>

        <div class="space-y-4">
          <%!-- Inbound --%>
          <.card>
            <.card_header class="pb-3">
              <.card_title class="text-base">Inbound CustomEvents</.card_title>
            </.card_header>
            <.card_content>
              <p class="text-sm text-muted-foreground mb-3">
                Dispatch events to a component element to control it imperatively.
                Event names use imperative verbs:
                <.inline_code>open</.inline_code>,
                <.inline_code>close</.inline_code>,
                <.inline_code>press</.inline_code>,
                <.inline_code>select</.inline_code>,
                <.inline_code>toggle</.inline_code>.
              </p>
              <pre class="rounded-md bg-muted p-3 text-xs font-mono overflow-x-auto"><code>{@code_inbound}</code></pre>
            </.card_content>
          </.card>

          <%!-- Outbound --%>
          <.card>
            <.card_header class="pb-3">
              <.card_title class="text-base">Outbound CustomEvents</.card_title>
            </.card_header>
            <.card_content>
              <p class="text-sm text-muted-foreground mb-3">
                Components emit events after state changes. Event names use past tense:
                <.inline_code>opened</.inline_code>,
                <.inline_code>closed</.inline_code>,
                <.inline_code>pressed</.inline_code>,
                <.inline_code>selected</.inline_code>.
                These don't bubble &mdash; listen directly on the component element.
              </p>
              <pre class="rounded-md bg-muted p-3 text-xs font-mono overflow-x-auto"><code>{@code_outbound}</code></pre>
            </.card_content>
          </.card>

          <%!-- push_event --%>
          <.card>
            <.card_header class="pb-3">
              <.card_title class="text-base">push_event (Server &rarr; Client)</.card_title>
            </.card_header>
            <.card_content>
              <p class="text-sm text-muted-foreground mb-3">
                The server can push commands to any component via
                <.inline_code>push_event/3</.inline_code>
                using the <.inline_code>phx_shadcn:command</.inline_code> channel.
                Target components by their <.inline_code>id</.inline_code>.
              </p>
              <pre class="rounded-md bg-muted p-3 text-xs font-mono overflow-x-auto"><code>{@code_push}</code></pre>
            </.card_content>
          </.card>
        </div>
      </.demo_section>

      <%!-- Section 2: Component ↔ Component --%>
      <.demo_section title="Component ↔ Component" code={showcase_source(:example_cross_component)}>
        <:description>
          A Toggle and a Collapsible wired together purely through outbound &rarr; inbound
          CustomEvents. Pressing the Toggle opens the Collapsible. Opening the Collapsible
          presses the Toggle. No server round-trips involved.
        </:description>

        {example_cross_component(assigns)}
      </.demo_section>

      <%!-- Section 3: Vanilla JS Control Panel --%>
      <.demo_section title="Vanilla JS Control Panel" code={showcase_source(:example_vanilla_js)}>
        <:description>
          Plain JavaScript buttons control components via
          <.inline_code>PhxShadcn.*</.inline_code> helpers.
          No LiveView, no Phoenix &mdash; just vanilla
          <.inline_code>onclick</.inline_code> handlers.
        </:description>

        {example_vanilla_js(assigns)}
      </.demo_section>

      <%!-- Section 4: Listening to Outbound Events --%>
      <.demo_section title="Listening to Outbound Events" code={showcase_source(:example_outbound_events)}>
        <:description>
          A Toggle and a Collapsible emit outbound CustomEvents.
          A pure-JS event log below captures them in real-time &mdash; no server round-trip.
        </:description>

        {example_outbound_events(assigns)}
      </.demo_section>

      <%!-- Section 5: External JS → Server-Controlled --%>
      <.demo_section title="External JS → Server-Controlled" code={showcase_source(:example_external_js_server)}>
        <:description>
          Inbound CustomEvents work even on server-controlled components.
          When JS dispatches <.inline_code>phx-shadcn:press</.inline_code>,
          the hook detects server mode, calls <.inline_code>notifyServer</.inline_code>,
          which triggers <.inline_code>handle_event/3</.inline_code>, updates the assign,
          and re-renders. The full round-trip confirms the state below.
        </:description>

        {example_external_js_server(assigns)}

        <.state_display label="Server pressed" value={inspect(@server_pressed)} />
      </.demo_section>

      <%!-- Section 6: Server → Client Push --%>
      <.demo_section title="Server → Client Push" code={showcase_source(:example_server_push)}>
        <:description>
          <.inline_code>push_event/3</.inline_code> commands multiple client-mode components
          at once from a single server button click. Both the Collapsible and Toggle below
          are client-only &mdash; no <.inline_code>open</.inline_code> or
          <.inline_code>pressed</.inline_code> assigns.
        </:description>

        {example_server_push(assigns)}
      </.demo_section>

      <%!-- Section 7: Event Reference Table --%>
      <.demo_section title="Event Reference">
        <:description>
          All inbound and outbound CustomEvents. Every event is prefixed with
          <.inline_code>phx-shadcn:</.inline_code>.
        </:description>

        <.card>
          <.card_content class="pt-0 pb-0 px-0">
            <.table>
              <.table_header>
                <.table_row>
                  <.table_head>Component</.table_head>
                  <.table_head>Inbound Events</.table_head>
                  <.table_head>Outbound Events</.table_head>
                </.table_row>
              </.table_header>
              <.table_body>
                <.table_row>
                  <.table_cell class="font-medium">Collapsible</.table_cell>
                  <.table_cell>
                    <span class="font-mono text-xs">open, close, toggle</span>
                  </.table_cell>
                  <.table_cell>
                    <span class="font-mono text-xs">opened, closed</span>
                  </.table_cell>
                </.table_row>
                <.table_row>
                  <.table_cell class="font-medium">Accordion</.table_cell>
                  <.table_cell>
                    <span class="font-mono text-xs">open, close, toggle</span>
                  </.table_cell>
                  <.table_cell>
                    <span class="font-mono text-xs">opened, closed</span>
                  </.table_cell>
                </.table_row>
                <.table_row>
                  <.table_cell class="font-medium">Toggle</.table_cell>
                  <.table_cell>
                    <span class="font-mono text-xs">press, unpress, toggle</span>
                  </.table_cell>
                  <.table_cell>
                    <span class="font-mono text-xs">pressed, unpressed</span>
                  </.table_cell>
                </.table_row>
                <.table_row>
                  <.table_cell class="font-medium">Switch</.table_cell>
                  <.table_cell>
                    <span class="font-mono text-xs">check, uncheck, toggle</span>
                  </.table_cell>
                  <.table_cell>
                    <span class="font-mono text-xs">checked, unchecked</span>
                  </.table_cell>
                </.table_row>
                <.table_row>
                  <.table_cell class="font-medium">ToggleGroup</.table_cell>
                  <.table_cell>
                    <span class="font-mono text-xs">select, deselect, toggle, set</span>
                  </.table_cell>
                  <.table_cell>
                    <span class="font-mono text-xs">selected, deselected</span>
                  </.table_cell>
                </.table_row>
                <.table_row>
                  <.table_cell class="font-medium">Progress</.table_cell>
                  <.table_cell>
                    <span class="font-mono text-xs">set</span>
                  </.table_cell>
                  <.table_cell>
                    <span class="font-mono text-xs">progress</span>
                  </.table_cell>
                </.table_row>
                <.table_row>
                  <.table_cell class="font-medium">Tabs</.table_cell>
                  <.table_cell>
                    <span class="font-mono text-xs">activate</span>
                  </.table_cell>
                  <.table_cell>
                    <span class="font-mono text-xs">tab-change</span>
                  </.table_cell>
                </.table_row>
              </.table_body>
            </.table>
          </.card_content>
        </.card>
      </.demo_section>
    </div>
    """
  end
end
