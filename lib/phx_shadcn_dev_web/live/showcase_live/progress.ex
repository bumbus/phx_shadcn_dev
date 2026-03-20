defmodule PhxShadcnDevWeb.ShowcaseLive.Progress do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Progress",
       # Hybrid mode state
       event_log: [],
       # Server-controlled progress state
       server_progress: 33
     )}
  end

  # ── Hybrid mode events ────────────────────────────────────────────

  @impl true
  def handle_event(
        "progress:change",
        %{"id" => "hybrid-progress", "value" => value} = params,
        socket
      ) do
    percentage = params["percentage"]
    state = params["state"]
    entry = "#{format_time()} → value: #{value}, #{percentage}%, #{state}"

    {:noreply,
     update(socket, :event_log, fn log ->
       Enum.take([entry | log], 10)
     end)}
  end

  # ── Server-controlled mode events ─────────────────────────────────

  def handle_event(
        "progress:change",
        %{"id" => "server-progress", "value" => value},
        socket
      ) do
    {:noreply, assign(socket, server_progress: value)}
  end

  # ── Server button controls ────────────────────────────────────────

  def handle_event("set-progress", %{"val" => val}, socket) do
    {:noreply, assign(socket, server_progress: String.to_integer(val))}
  end

  def handle_event("increment-progress", _params, socket) do
    new_val = min(socket.assigns.server_progress + 10, 100)
    {:noreply, assign(socket, server_progress: new_val)}
  end

  # ── Push event demo ──────────────────────────────────────────────

  def handle_event("push-progress", %{"val" => val}, socket) do
    {:noreply,
     push_event(socket, "phx_shadcn:command", %{
       id: "push-progress",
       command: "set",
       value: String.to_integer(val)
     })}
  end

  def handle_event("clear-log", _params, socket) do
    {:noreply, assign(socket, event_log: [])}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_client_only(assigns) do
    ~H"""
    <.progress id="client-progress" default_value={33} />
    <div class="flex flex-wrap gap-2">
      <button
        class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
        onclick="PhxShadcn.set('client-progress', 0)"
      >
        0%
      </button>
      <button
        class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
        onclick="PhxShadcn.set('client-progress', 25)"
      >
        25%
      </button>
      <button
        class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
        onclick="PhxShadcn.set('client-progress', 50)"
      >
        50%
      </button>
      <button
        class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
        onclick="PhxShadcn.set('client-progress', 75)"
      >
        75%
      </button>
      <button
        class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
        onclick="PhxShadcn.set('client-progress', 100)"
      >
        100%
      </button>
    </div>
    """
  end

  defp example_indeterminate(assigns) do
    ~H"""
    <.progress id="indeterminate-progress" />
    """
  end

  defp example_hybrid(assigns) do
    ~H"""
    <.progress id="hybrid-progress" default_value={0} on_value_change="progress:change" />
    <div class="flex flex-wrap gap-2">
      <button
        class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
        onclick="PhxShadcn.set('hybrid-progress', 25)"
      >
        25%
      </button>
      <button
        class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
        onclick="PhxShadcn.set('hybrid-progress', 50)"
      >
        50%
      </button>
      <button
        class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
        onclick="PhxShadcn.set('hybrid-progress', 75)"
      >
        75%
      </button>
      <button
        class="inline-flex items-center justify-center rounded-md border border-input bg-background px-3 py-1.5 text-sm font-medium hover:bg-accent hover:text-accent-foreground cursor-pointer"
        onclick="PhxShadcn.set('hybrid-progress', 100)"
      >
        100%
      </button>
    </div>
    """
  end

  defp example_server_controlled(assigns) do
    ~H"""
    <div class="flex flex-wrap gap-2 mb-3">
      <.button size="sm" variant="outline" phx-click="set-progress" phx-value-val="0">
        0%
      </.button>
      <.button size="sm" variant="outline" phx-click="set-progress" phx-value-val="25">
        25%
      </.button>
      <.button size="sm" variant="outline" phx-click="set-progress" phx-value-val="50">
        50%
      </.button>
      <.button size="sm" variant="outline" phx-click="increment-progress">
        +10%
      </.button>
      <.button size="sm" variant="outline" phx-click="set-progress" phx-value-val="100">
        100%
      </.button>
    </div>

    <.card>
      <.card_content class="pt-6">
        <.progress
          id="server-progress"
          value={@server_progress}
          on_value_change="progress:change"
        />
      </.card_content>
    </.card>
    """
  end

  defp example_push_event(assigns) do
    ~H"""
    <div class="flex flex-wrap gap-2">
      <.button size="sm" variant="outline" phx-click="push-progress" phx-value-val="0">0%</.button>
      <.button size="sm" variant="outline" phx-click="push-progress" phx-value-val="25">25%</.button>
      <.button size="sm" variant="outline" phx-click="push-progress" phx-value-val="50">50%</.button>
      <.button size="sm" variant="outline" phx-click="push-progress" phx-value-val="75">75%</.button>
      <.button size="sm" variant="outline" phx-click="push-progress" phx-value-val="100">100%</.button>
    </div>

    <.card>
      <.card_content class="pt-6">
        <.progress id="push-progress" default_value={0} />
      </.card_content>
    </.card>
    """
  end

  # ── Render ───────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Progress" storybook="/storybook/progress">
        Displays an indicator showing the completion progress of a task.
        Demonstrated in all 3 state modes plus indeterminate.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Client-only Progress --%>
      <.demo_section title="Client-only Progress" code={showcase_source(:example_client_only)}>
        <:description>
          No server events. Vanilla JS buttons update the progress bar via
          CustomEvent — zero latency.
        </:description>
        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_client_only(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Indeterminate --%>
      <.demo_section title="Indeterminate" code={showcase_source(:example_indeterminate)}>
        <:description>
          When no value is set, the progress bar shows an
          indeterminate animation — useful for loading states where completion is unknown.
        </:description>
        <.card>
          <.card_content class="pt-6">
            {example_indeterminate(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: Hybrid --%>
      <.demo_section title="Hybrid" code={showcase_source(:example_hybrid)}>
        <:description>
          JS updates instantly for responsiveness, then pushes the event to the server.
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
          The server owns the state. Use the buttons below to control the progress externally.
        </:description>

        {example_server_controlled(assigns)}

        <.state_display label="Server value" value={"#{@server_progress}%"} />
      </.demo_section>

      <%!-- Demo 5: Push Event --%>
      <.demo_section title="Push Event (Server → Client)" code={showcase_source(:example_push_event)}>
        <:description>
          The server pushes commands to a client-mode progress bar via
          push_event/3.
          The progress has no value or
          on_value_change — it's client-only,
          but the server can still command it.
        </:description>

        {example_push_event(assigns)}
      </.demo_section>
    </div>
    """
  end
end
