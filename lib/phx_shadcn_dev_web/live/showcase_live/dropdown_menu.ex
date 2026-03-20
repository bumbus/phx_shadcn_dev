defmodule PhxShadcnDevWeb.ShowcaseLive.DropdownMenu do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "DropdownMenu",
       # Checkbox items demo
       status_bar: true,
       activity_bar: false,
       panel: true,
       # Radio group demo
       theme: "system",
       # Server-controlled demo
       show_server_menu: false,
       server_action: nil
     )}
  end

  # ── Checkbox item events ──────────────────────────────────────────

  @impl true
  def handle_event("toggle-status-bar", _params, socket) do
    {:noreply, assign(socket, status_bar: !socket.assigns.status_bar)}
  end

  def handle_event("toggle-activity-bar", _params, socket) do
    {:noreply, assign(socket, activity_bar: !socket.assigns.activity_bar)}
  end

  def handle_event("toggle-panel", _params, socket) do
    {:noreply, assign(socket, panel: !socket.assigns.panel)}
  end

  # ── Radio group events ────────────────────────────────────────────

  def handle_event("set-theme", %{"val" => theme}, socket) do
    {:noreply, assign(socket, theme: theme)}
  end

  # ── Server-controlled events ──────────────────────────────────────

  def handle_event("open-server-menu", _params, socket) do
    {:noreply, assign(socket, show_server_menu: true)}
  end

  def handle_event("close-server-menu", _params, socket) do
    {:noreply, assign(socket, show_server_menu: false)}
  end

  def handle_event("server-action", %{"val" => action}, socket) do
    {:noreply, assign(socket, server_action: action)}
  end

  # ── Examples (source extracted at compile time) ───────────────────

  defp example_basic(assigns) do
    ~H"""
    <.dropdown_menu id="basic-menu">
      <.dropdown_menu_trigger>
        <.button variant="outline">Open Menu</.button>
      </.dropdown_menu_trigger>
      <.dropdown_menu_content>
        <.dropdown_menu_label>My Account</.dropdown_menu_label>
        <.dropdown_menu_separator />
        <.dropdown_menu_item>Profile</.dropdown_menu_item>
        <.dropdown_menu_item>Billing</.dropdown_menu_item>
        <.dropdown_menu_item>Settings</.dropdown_menu_item>
        <.dropdown_menu_separator />
        <.dropdown_menu_item>Log out</.dropdown_menu_item>
      </.dropdown_menu_content>
    </.dropdown_menu>
    """
  end

  defp example_complex(assigns) do
    ~H"""
    <.dropdown_menu id="complex-menu">
      <.dropdown_menu_trigger>
        <.button variant="outline">Open</.button>
      </.dropdown_menu_trigger>
      <.dropdown_menu_content class="w-56">
        <.dropdown_menu_item>
          <.icon name="hero-arrow-uturn-left-micro" />
          Back
          <.dropdown_menu_shortcut>⌘[</.dropdown_menu_shortcut>
        </.dropdown_menu_item>
        <.dropdown_menu_item disabled>
          <.icon name="hero-arrow-uturn-right-micro" />
          Forward
          <.dropdown_menu_shortcut>⌘]</.dropdown_menu_shortcut>
        </.dropdown_menu_item>
        <.dropdown_menu_item>
          <.icon name="hero-arrow-path-micro" />
          Reload
          <.dropdown_menu_shortcut>⌘R</.dropdown_menu_shortcut>
        </.dropdown_menu_item>
        <.dropdown_menu_separator />
        <.dropdown_menu_sub>
          <.dropdown_menu_sub_trigger>
            <.icon name="hero-users-micro" />
            More Tools
          </.dropdown_menu_sub_trigger>
          <.dropdown_menu_sub_content>
            <.dropdown_menu_item>
              <.icon name="hero-document-text-micro" />
              Save Page As...
              <.dropdown_menu_shortcut>⇧⌘S</.dropdown_menu_shortcut>
            </.dropdown_menu_item>
            <.dropdown_menu_item>
              <.icon name="hero-folder-micro" />
              Create Shortcut...
            </.dropdown_menu_item>
            <.dropdown_menu_item>
              <.icon name="hero-window-micro" />
              Name Window...
            </.dropdown_menu_item>
            <.dropdown_menu_separator />
            <.dropdown_menu_item>
              <.icon name="hero-wrench-screwdriver-micro" />
              Developer Tools
            </.dropdown_menu_item>
          </.dropdown_menu_sub_content>
        </.dropdown_menu_sub>
        <.dropdown_menu_separator />
        <.dropdown_menu_checkbox_item checked={@status_bar} phx-click="toggle-status-bar">
          Show Bookmarks Bar
          <.dropdown_menu_shortcut>⌘⇧B</.dropdown_menu_shortcut>
        </.dropdown_menu_checkbox_item>
        <.dropdown_menu_checkbox_item checked={@panel} phx-click="toggle-panel">
          Show Full URLs
        </.dropdown_menu_checkbox_item>
        <.dropdown_menu_separator />
        <.dropdown_menu_label inset>People</.dropdown_menu_label>
        <.dropdown_menu_radio_group>
          <.dropdown_menu_radio_item
            :for={person <- ~w(Pedro Colm)}
            checked={@theme == person}
            phx-click="set-theme"
            phx-value-val={person}
          >
            {person}
          </.dropdown_menu_radio_item>
        </.dropdown_menu_radio_group>
      </.dropdown_menu_content>
    </.dropdown_menu>
    """
  end

  defp example_shortcuts(assigns) do
    ~H"""
    <.dropdown_menu id="shortcut-menu">
      <.dropdown_menu_trigger>
        <.button variant="outline">Actions</.button>
      </.dropdown_menu_trigger>
      <.dropdown_menu_content class="w-56">
        <.dropdown_menu_label>Actions</.dropdown_menu_label>
        <.dropdown_menu_separator />
        <.dropdown_menu_item>
          New Tab
          <.dropdown_menu_shortcut>⌘T</.dropdown_menu_shortcut>
        </.dropdown_menu_item>
        <.dropdown_menu_item>
          New Window
          <.dropdown_menu_shortcut>⌘N</.dropdown_menu_shortcut>
        </.dropdown_menu_item>
        <.dropdown_menu_item disabled>
          New Private Window
          <.dropdown_menu_shortcut>⇧⌘N</.dropdown_menu_shortcut>
        </.dropdown_menu_item>
        <.dropdown_menu_separator />
        <.dropdown_menu_item>
          Command Palette
          <.dropdown_menu_shortcut>⇧⌘P</.dropdown_menu_shortcut>
        </.dropdown_menu_item>
      </.dropdown_menu_content>
    </.dropdown_menu>
    """
  end

  defp example_checkbox_items(assigns) do
    ~H"""
    <.dropdown_menu id="checkbox-menu">
      <.dropdown_menu_trigger>
        <.button variant="outline">View</.button>
      </.dropdown_menu_trigger>
      <.dropdown_menu_content class="w-56">
        <.dropdown_menu_label>Appearance</.dropdown_menu_label>
        <.dropdown_menu_separator />
        <.dropdown_menu_checkbox_item checked={@status_bar} phx-click="toggle-status-bar">
          Status Bar
        </.dropdown_menu_checkbox_item>
        <.dropdown_menu_checkbox_item checked={@activity_bar} phx-click="toggle-activity-bar">
          Activity Bar
        </.dropdown_menu_checkbox_item>
        <.dropdown_menu_checkbox_item checked={@panel} phx-click="toggle-panel">
          Panel
        </.dropdown_menu_checkbox_item>
      </.dropdown_menu_content>
    </.dropdown_menu>
    """
  end

  defp example_radio_group(assigns) do
    ~H"""
    <.dropdown_menu id="radio-menu">
      <.dropdown_menu_trigger>
        <.button variant="outline">Theme: {String.capitalize(@theme)}</.button>
      </.dropdown_menu_trigger>
      <.dropdown_menu_content class="w-56">
        <.dropdown_menu_label>Theme</.dropdown_menu_label>
        <.dropdown_menu_separator />
        <.dropdown_menu_radio_group>
          <.dropdown_menu_radio_item
            :for={opt <- ~w(light dark system)}
            checked={@theme == opt}
            phx-click="set-theme"
            phx-value-val={opt}
          >
            {String.capitalize(opt)}
          </.dropdown_menu_radio_item>
        </.dropdown_menu_radio_group>
      </.dropdown_menu_content>
    </.dropdown_menu>
    """
  end

  defp example_icons(assigns) do
    ~H"""
    <.dropdown_menu id="icon-menu">
      <.dropdown_menu_trigger>
        <.button variant="outline">Options</.button>
      </.dropdown_menu_trigger>
      <.dropdown_menu_content class="w-56">
        <.dropdown_menu_group>
          <.dropdown_menu_item>
            <.icon name="hero-user-micro" />
            Profile
            <.dropdown_menu_shortcut>⇧⌘P</.dropdown_menu_shortcut>
          </.dropdown_menu_item>
          <.dropdown_menu_item>
            <.icon name="hero-credit-card-micro" />
            Billing
            <.dropdown_menu_shortcut>⌘B</.dropdown_menu_shortcut>
          </.dropdown_menu_item>
          <.dropdown_menu_item>
            <.icon name="hero-cog-6-tooth-micro" />
            Settings
            <.dropdown_menu_shortcut>⌘S</.dropdown_menu_shortcut>
          </.dropdown_menu_item>
        </.dropdown_menu_group>
        <.dropdown_menu_separator />
        <.dropdown_menu_item>
          <.icon name="hero-arrow-right-start-on-rectangle-micro" />
          Log out
          <.dropdown_menu_shortcut>⇧⌘Q</.dropdown_menu_shortcut>
        </.dropdown_menu_item>
      </.dropdown_menu_content>
    </.dropdown_menu>
    """
  end

  defp example_destructive(assigns) do
    ~H"""
    <.dropdown_menu id="destructive-menu">
      <.dropdown_menu_trigger>
        <.button variant="outline">Manage</.button>
      </.dropdown_menu_trigger>
      <.dropdown_menu_content class="w-56">
        <.dropdown_menu_label>Account</.dropdown_menu_label>
        <.dropdown_menu_separator />
        <.dropdown_menu_item>Profile</.dropdown_menu_item>
        <.dropdown_menu_item>Settings</.dropdown_menu_item>
        <.dropdown_menu_separator />
        <.dropdown_menu_item variant="destructive">
          <.icon name="hero-trash-micro" />
          Delete Account
        </.dropdown_menu_item>
      </.dropdown_menu_content>
    </.dropdown_menu>
    """
  end

  defp example_disabled(assigns) do
    ~H"""
    <.dropdown_menu id="disabled-menu">
      <.dropdown_menu_trigger>
        <.button variant="outline">Edit</.button>
      </.dropdown_menu_trigger>
      <.dropdown_menu_content class="w-56">
        <.dropdown_menu_item>Undo</.dropdown_menu_item>
        <.dropdown_menu_item>Redo</.dropdown_menu_item>
        <.dropdown_menu_separator />
        <.dropdown_menu_item>Cut</.dropdown_menu_item>
        <.dropdown_menu_item>Copy</.dropdown_menu_item>
        <.dropdown_menu_item disabled>Paste</.dropdown_menu_item>
        <.dropdown_menu_separator />
        <.dropdown_menu_item disabled>Delete</.dropdown_menu_item>
        <.dropdown_menu_item>Select All</.dropdown_menu_item>
      </.dropdown_menu_content>
    </.dropdown_menu>
    """
  end

  defp example_placement(assigns) do
    ~H"""
    <.dropdown_menu :for={side <- ~w(top right bottom left)} id={"place-#{side}"}>
      <.dropdown_menu_trigger>
        <.button variant="outline">{String.capitalize(side)}</.button>
      </.dropdown_menu_trigger>
      <.dropdown_menu_content side={side}>
        <.dropdown_menu_item>Item One</.dropdown_menu_item>
        <.dropdown_menu_item>Item Two</.dropdown_menu_item>
        <.dropdown_menu_item>Item Three</.dropdown_menu_item>
      </.dropdown_menu_content>
    </.dropdown_menu>
    """
  end

  defp example_server_controlled(assigns) do
    ~H"""
    <.button phx-click="open-server-menu">Open Menu</.button>

    <div :if={@server_action} class="text-sm text-muted-foreground">
      Last action: {@server_action}
    </div>
    """
  end

  # ── Render ────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="DropdownMenu" storybook="/storybook/dropdown_menu">
        A click-triggered floating menu with keyboard navigation, typeahead,
        checkbox/radio items, and ARIA menu semantics.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Basic --%>
      <.demo_section title="Basic" code={showcase_source(:example_basic)}>
        <:description>
          A simple menu with items. Click the trigger or press Enter/ArrowDown to open.
          Arrow keys navigate, Enter/Space activate, Escape closes.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_basic(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Complex with Sub-menus --%>
      <.demo_section title="Complex with Sub-menus" code={showcase_source(:example_complex)}>
        <:description>
          Nested sub-menus open on hover or ArrowRight. ArrowLeft closes the sub-menu.
          Mirrors the shadcn "complex" example.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_complex(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: With Shortcuts --%>
      <.demo_section title="With Shortcuts" code={showcase_source(:example_shortcuts)}>
        <:description>
          Items with keyboard shortcut hints displayed on the right.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_shortcuts(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 4: Checkbox Items --%>
      <.demo_section title="Checkbox Items" code={showcase_source(:example_checkbox_items)}>
        <:description>
          Toggleable items with server-driven checked state. Menu stays open on toggle.
        </:description>

        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_checkbox_items(assigns)}

            <.state_display
              label="Server state"
              value={"status_bar=#{@status_bar}, activity_bar=#{@activity_bar}, panel=#{@panel}"}
            />
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 5: Radio Group --%>
      <.demo_section title="Radio Group" code={showcase_source(:example_radio_group)}>
        <:description>
          Single-selection items via radio group and radio items.
        </:description>

        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_radio_group(assigns)}

            <.state_display label="Server state" value={"theme=#{@theme}"} />
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 6: With Icons --%>
      <.demo_section title="With Icons" code={showcase_source(:example_icons)}>
        <:description>
          Items with leading icons.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_icons(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 7: Destructive Item --%>
      <.demo_section title="Destructive Item" code={showcase_source(:example_destructive)}>
        <:description>
          Use variant="destructive" for dangerous actions.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_destructive(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 8: Disabled Items --%>
      <.demo_section title="Disabled Items" code={showcase_source(:example_disabled)}>
        <:description>
          Disabled items are visually dimmed and skipped by keyboard navigation.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_disabled(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 9: Placement --%>
      <.demo_section title="Placement" code={showcase_source(:example_placement)}>
        <:description>
          Different side and align combinations. The menu flips if there isn't enough space.
        </:description>

        <.card>
          <.card_content class="pt-6 flex flex-wrap justify-center gap-3">
            {example_placement(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 10: Server-controlled --%>
      <.demo_section title="Server-controlled" code={showcase_source(:example_server_controlled)}>
        <:description>
          Server controls open/close state. Uses the
          :if + show pattern.
        </:description>

        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_server_controlled(assigns)}
          </.card_content>
        </.card>

        <.dropdown_menu
          :if={@show_server_menu}
          id="server-menu"
          show
          on_open_change={JS.push("close-server-menu")}
        >
          <.dropdown_menu_trigger>
            <.button variant="outline">Server Menu</.button>
          </.dropdown_menu_trigger>
          <.dropdown_menu_content class="w-56">
            <.dropdown_menu_label>Server Actions</.dropdown_menu_label>
            <.dropdown_menu_separator />
            <.dropdown_menu_item phx-click="server-action" phx-value-val="profile">
              Profile
            </.dropdown_menu_item>
            <.dropdown_menu_item phx-click="server-action" phx-value-val="settings">
              Settings
            </.dropdown_menu_item>
            <.dropdown_menu_separator />
            <.dropdown_menu_item phx-click="server-action" phx-value-val="logout">
              Log out
            </.dropdown_menu_item>
          </.dropdown_menu_content>
        </.dropdown_menu>

        <.state_display
          label="Server state"
          value={"show=#{@show_server_menu}, action=#{inspect(@server_action)}"}
        />
      </.demo_section>
    </div>
    """
  end
end
