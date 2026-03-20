defmodule PhxShadcnDevWeb.ShowcaseLive.Tabs do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Tabs",
       # Hybrid mode state
       event_log: [],
       # Server-controlled tab
       server_tab: "account",
       # Patch mode tabs (set in handle_params)
       patch_tab: "overview",
       query_tab: "overview"
     )}
  end

  @impl true
  def handle_params(_params, uri, socket) do
    parsed = URI.parse(uri)

    # Distinguish path param from query param by inspecting the URI directly,
    # since LiveView merges both into params.
    path_tab =
      case String.split(parsed.path, "/") do
        ["", "showcase", "tabs", tab] -> tab
        _ -> nil
      end

    query_tab =
      if parsed.query do
        parsed.query |> URI.decode_query() |> Map.get("tab")
      end

    # Update only the demo that was triggered, preserve the other
    socket = if path_tab, do: assign(socket, :patch_tab, path_tab), else: socket
    socket = if query_tab, do: assign(socket, :query_tab, query_tab), else: socket

    {:noreply, socket}
  end

  # ── Hybrid mode events ────────────────────────────────────────────

  @impl true
  def handle_event("tabs:change", %{"id" => "hybrid-tabs", "value" => value}, socket) do
    entry = "#{format_time()} → tab: #{value}"

    {:noreply,
     update(socket, :event_log, fn log ->
       Enum.take([entry | log], 10)
     end)}
  end

  # ── Server-controlled mode events ─────────────────────────────────

  def handle_event("tabs:change", %{"id" => "server-tabs", "value" => value}, socket) do
    {:noreply, assign(socket, server_tab: value)}
  end

  # ── Server button controls ────────────────────────────────────────

  def handle_event("set-tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, server_tab: tab)}
  end

  # ── Push event demo ──────────────────────────────────────────────

  def handle_event("push-activate", %{"tab" => tab}, socket) do
    {:noreply,
     push_event(socket, "phx_shadcn:command", %{id: "push-tabs", command: "activate", value: tab})}
  end

  def handle_event("clear-log", _params, socket) do
    {:noreply, assign(socket, event_log: [])}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_client_only(assigns) do
    ~H"""
    <.tabs id="client-tabs" default_value="account">
      <.tabs_list>
        <.tabs_trigger value="account">Account</.tabs_trigger>
        <.tabs_trigger value="password">Password</.tabs_trigger>
        <.tabs_trigger value="notifications">Notifications</.tabs_trigger>
      </.tabs_list>
      <.tabs_content value="account" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">Account</h3>
          <p class="text-sm text-muted-foreground">
            Make changes to your account here. Click save when you're done.
          </p>
        </div>
      </.tabs_content>
      <.tabs_content value="password" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">Password</h3>
          <p class="text-sm text-muted-foreground">
            Change your password here. After saving, you'll be logged out.
          </p>
        </div>
      </.tabs_content>
      <.tabs_content value="notifications" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">Notifications</h3>
          <p class="text-sm text-muted-foreground">
            Configure how you receive notifications.
          </p>
        </div>
      </.tabs_content>
    </.tabs>
    """
  end

  defp example_line_variant(assigns) do
    ~H"""
    <.tabs id="line-tabs" default_value="overview">
      <.tabs_list variant="line">
        <.tabs_trigger value="overview">Overview</.tabs_trigger>
        <.tabs_trigger value="analytics">Analytics</.tabs_trigger>
        <.tabs_trigger value="reports">Reports</.tabs_trigger>
        <.tabs_trigger value="settings" disabled>Settings</.tabs_trigger>
      </.tabs_list>
      <.tabs_content value="overview" class="p-4">
        <p class="text-sm text-muted-foreground">
          Project overview with key metrics and recent activity.
        </p>
      </.tabs_content>
      <.tabs_content value="analytics" class="p-4">
        <p class="text-sm text-muted-foreground">
          Detailed analytics and performance data.
        </p>
      </.tabs_content>
      <.tabs_content value="reports" class="p-4">
        <p class="text-sm text-muted-foreground">
          Generated reports and exports.
        </p>
      </.tabs_content>
      <.tabs_content value="settings" class="p-4">
        <p class="text-sm text-muted-foreground">
          This tab is disabled and shouldn't be reachable.
        </p>
      </.tabs_content>
    </.tabs>
    """
  end

  defp example_vertical(assigns) do
    ~H"""
    <.tabs id="vertical-tabs" default_value="general" orientation="vertical">
      <.tabs_list>
        <.tabs_trigger value="general">General</.tabs_trigger>
        <.tabs_trigger value="security">Security</.tabs_trigger>
        <.tabs_trigger value="integrations">Integrations</.tabs_trigger>
        <.tabs_trigger value="billing">Billing</.tabs_trigger>
      </.tabs_list>
      <.tabs_content value="general" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">General Settings</h3>
          <p class="text-sm text-muted-foreground">
            Manage your workspace name, description, and default preferences.
          </p>
        </div>
      </.tabs_content>
      <.tabs_content value="security" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">Security</h3>
          <p class="text-sm text-muted-foreground">
            Configure two-factor authentication and session management.
          </p>
        </div>
      </.tabs_content>
      <.tabs_content value="integrations" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">Integrations</h3>
          <p class="text-sm text-muted-foreground">
            Connect third-party services and manage API keys.
          </p>
        </div>
      </.tabs_content>
      <.tabs_content value="billing" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">Billing</h3>
          <p class="text-sm text-muted-foreground">
            View invoices, manage payment methods, and update your plan.
          </p>
        </div>
      </.tabs_content>
    </.tabs>
    """
  end

  defp example_hybrid(assigns) do
    ~H"""
    <.tabs id="hybrid-tabs" default_value="tab1" on_value_change="tabs:change">
      <.tabs_list>
        <.tabs_trigger value="tab1">First</.tabs_trigger>
        <.tabs_trigger value="tab2">Second</.tabs_trigger>
        <.tabs_trigger value="tab3">Third</.tabs_trigger>
      </.tabs_list>
      <.tabs_content value="tab1" class="p-4">
        <p class="text-sm text-muted-foreground">Content for the first tab.</p>
      </.tabs_content>
      <.tabs_content value="tab2" class="p-4">
        <p class="text-sm text-muted-foreground">Content for the second tab.</p>
      </.tabs_content>
      <.tabs_content value="tab3" class="p-4">
        <p class="text-sm text-muted-foreground">Content for the third tab.</p>
      </.tabs_content>
    </.tabs>
    """
  end

  defp example_server_controlled(assigns) do
    ~H"""
    <div class="flex flex-wrap gap-2 mb-3">
      <.button size="sm" variant="outline" phx-click="set-tab" phx-value-tab="account">
        Account
      </.button>
      <.button size="sm" variant="outline" phx-click="set-tab" phx-value-tab="password">
        Password
      </.button>
      <.button size="sm" variant="outline" phx-click="set-tab" phx-value-tab="billing">
        Billing
      </.button>
    </div>

    <.tabs id="server-tabs" value={@server_tab} on_value_change="tabs:change">
      <.tabs_list>
        <.tabs_trigger value="account">Account</.tabs_trigger>
        <.tabs_trigger value="password">Password</.tabs_trigger>
        <.tabs_trigger value="billing">Billing</.tabs_trigger>
      </.tabs_list>
      <.tabs_content :if={@server_tab == "account"} value="account" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">Account</h3>
          <p class="text-sm text-muted-foreground">
            Server-rendered account settings. Only this panel is in the DOM.
          </p>
        </div>
      </.tabs_content>
      <.tabs_content :if={@server_tab == "password"} value="password" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">Password</h3>
          <p class="text-sm text-muted-foreground">
            Server-rendered password settings.
          </p>
        </div>
      </.tabs_content>
      <.tabs_content :if={@server_tab == "billing"} value="billing" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">Billing</h3>
          <p class="text-sm text-muted-foreground">
            Server-rendered billing information.
          </p>
        </div>
      </.tabs_content>
    </.tabs>
    """
  end

  defp example_push_event(assigns) do
    ~H"""
    <div class="flex flex-wrap gap-2">
      <.button size="sm" variant="outline" phx-click="push-activate" phx-value-tab="music">Music</.button>
      <.button size="sm" variant="outline" phx-click="push-activate" phx-value-tab="podcasts">Podcasts</.button>
      <.button size="sm" variant="outline" phx-click="push-activate" phx-value-tab="audiobooks">Audiobooks</.button>
    </div>

    <.tabs id="push-tabs" default_value="music">
      <.tabs_list>
        <.tabs_trigger value="music">Music</.tabs_trigger>
        <.tabs_trigger value="podcasts">Podcasts</.tabs_trigger>
        <.tabs_trigger value="audiobooks">Audiobooks</.tabs_trigger>
      </.tabs_list>
      <.tabs_content value="music" class="p-4">
        <p class="text-sm text-muted-foreground">Your music library.</p>
      </.tabs_content>
      <.tabs_content value="podcasts" class="p-4">
        <p class="text-sm text-muted-foreground">Your podcast subscriptions.</p>
      </.tabs_content>
      <.tabs_content value="audiobooks" class="p-4">
        <p class="text-sm text-muted-foreground">Your audiobook collection.</p>
      </.tabs_content>
    </.tabs>
    """
  end

  defp example_patch_path(assigns) do
    ~H"""
    <.tabs id="patch-tabs" value={@patch_tab}>
      <.tabs_list>
        <.tabs_trigger value="overview" patch={~p"/showcase/tabs/overview"}>Overview</.tabs_trigger>
        <.tabs_trigger value="members" patch={~p"/showcase/tabs/members"}>Members</.tabs_trigger>
        <.tabs_trigger value="settings" patch={~p"/showcase/tabs/settings"}>Settings</.tabs_trigger>
      </.tabs_list>
      <.tabs_content :if={@patch_tab == "overview"} value="overview" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">Overview</h3>
          <p class="text-sm text-muted-foreground">
            The URL now shows <code class="rounded bg-muted px-1 py-0.5">/showcase/tabs/overview</code>.
            Try the browser back/forward buttons.
          </p>
        </div>
      </.tabs_content>
      <.tabs_content :if={@patch_tab == "members"} value="members" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">Members</h3>
          <p class="text-sm text-muted-foreground">
            The URL now shows <code class="rounded bg-muted px-1 py-0.5">/showcase/tabs/members</code>.
          </p>
        </div>
      </.tabs_content>
      <.tabs_content :if={@patch_tab == "settings"} value="settings" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">Settings</h3>
          <p class="text-sm text-muted-foreground">
            The URL now shows <code class="rounded bg-muted px-1 py-0.5">/showcase/tabs/settings</code>.
          </p>
        </div>
      </.tabs_content>
    </.tabs>
    """
  end

  defp example_patch_query(assigns) do
    ~H"""
    <.tabs id="query-tabs" value={@query_tab}>
      <.tabs_list>
        <.tabs_trigger value="overview" patch={~p"/showcase/tabs?tab=overview"}>Overview</.tabs_trigger>
        <.tabs_trigger value="members" patch={~p"/showcase/tabs?tab=members"}>Members</.tabs_trigger>
        <.tabs_trigger value="settings" patch={~p"/showcase/tabs?tab=settings"}>Settings</.tabs_trigger>
      </.tabs_list>
      <.tabs_content :if={@query_tab == "overview"} value="overview" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">Overview</h3>
          <p class="text-sm text-muted-foreground">
            The URL now shows <code class="rounded bg-muted px-1 py-0.5">?tab=overview</code>.
          </p>
        </div>
      </.tabs_content>
      <.tabs_content :if={@query_tab == "members"} value="members" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">Members</h3>
          <p class="text-sm text-muted-foreground">
            The URL now shows <code class="rounded bg-muted px-1 py-0.5">?tab=members</code>.
          </p>
        </div>
      </.tabs_content>
      <.tabs_content :if={@query_tab == "settings"} value="settings" class="p-4">
        <div class="space-y-2">
          <h3 class="text-lg font-medium">Settings</h3>
          <p class="text-sm text-muted-foreground">
            The URL now shows <code class="rounded bg-muted px-1 py-0.5">?tab=settings</code>.
          </p>
        </div>
      </.tabs_content>
    </.tabs>
    """
  end

  # ── Render ───────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Tabs" storybook="/storybook/tabs">
        A set of layered sections of content — known as tab panels — that are
        displayed one at a time. Demonstrated in all state modes plus patch mode.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Client-only Tabs --%>
      <.demo_section title="Client-only Tabs" code={showcase_source(:example_client_only)}>
        <:description>
          No server events. Tab switching happens purely via JavaScript — zero latency.
        </:description>
        <.card>
          <.card_content class="pt-6">
            {example_client_only(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Line Variant --%>
      <.demo_section title="Line Variant" code={showcase_source(:example_line_variant)}>
        <:description>
          The line variant uses an underline indicator instead of a
          background pill. The ::after pseudo-element provides the
          active underline.
        </:description>
        <.card>
          <.card_content class="pt-6">
            {example_line_variant(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: Vertical Orientation --%>
      <.demo_section title="Vertical Orientation" code={showcase_source(:example_vertical)}>
        <:description>
          Set orientation="vertical" for side-by-side layout.
          Arrow keys switch from horizontal (Left/Right) to vertical (Up/Down).
        </:description>
        <.card>
          <.card_content class="pt-6">
            {example_vertical(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 4: Hybrid --%>
      <.demo_section title="Hybrid" code={showcase_source(:example_hybrid)}>
        <:description>
          JS switches tabs instantly for responsiveness, then pushes the event to the server.
          The event log below updates via LiveView.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_hybrid(assigns)}
          </.card_content>
        </.card>

        <.event_log entries={@event_log} />
      </.demo_section>

      <%!-- Demo 5: Server-controlled --%>
      <.demo_section title="Server-controlled" code={showcase_source(:example_server_controlled)}>
        <:description>
          The server owns the state. Use the buttons below to control the active tab externally.
          Content panels use :if — only the active panel is in the DOM.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_server_controlled(assigns)}
          </.card_content>
        </.card>

        <.state_display label="Server tab" value={inspect(@server_tab)} />
      </.demo_section>

      <%!-- Demo 6: Push Event --%>
      <.demo_section title="Push Event (Server → Client)" code={showcase_source(:example_push_event)}>
        <:description>
          The server pushes commands to a client-mode tabs via
          push_event/3.
          The tabs have no value or
          on_value_change — they're client-only,
          but the server can still command them.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_push_event(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 7: Patch Mode — Path Params --%>
      <.demo_section title="Patch Mode — Path Params" code={showcase_source(:example_patch_path)}>
        <:description>
          Triggers render as link patches instead of buttons.
          The URL updates to /showcase/tabs/:tab and
          handle_params/3 reads the active tab from the path.
          Supports browser back/forward navigation.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_patch_path(assigns)}
          </.card_content>
        </.card>

        <.state_display label="Path param tab" value={inspect(@patch_tab)} />
      </.demo_section>

      <%!-- Demo 8: Patch Mode — Query Params --%>
      <.demo_section title="Patch Mode — Query Params" code={showcase_source(:example_patch_query)}>
        <:description>
          Same pattern but with query parameters:
          /showcase/tabs?tab=....
          Useful when you want tabs on a page without changing the route path.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_patch_query(assigns)}
          </.card_content>
        </.card>

        <.state_display label="Query param tab" value={inspect(@query_tab)} />
      </.demo_section>
    </div>
    """
  end
end
