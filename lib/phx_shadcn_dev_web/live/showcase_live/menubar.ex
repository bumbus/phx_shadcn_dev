defmodule PhxShadcnDevWeb.ShowcaseLive.Menubar do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Menubar",
       # Checkbox items
       show_bookmarks_bar: true,
       show_full_urls: false,
       # Radio group
       profile: "benoit"
     )}
  end

  # ── Checkbox item events ──────────────────────────────────────────

  @impl true
  def handle_event("toggle-bookmarks-bar", _params, socket) do
    {:noreply, assign(socket, show_bookmarks_bar: !socket.assigns.show_bookmarks_bar)}
  end

  def handle_event("toggle-full-urls", _params, socket) do
    {:noreply, assign(socket, show_full_urls: !socket.assigns.show_full_urls)}
  end

  # ── Radio group events ────────────────────────────────────────────

  def handle_event("set-profile", %{"val" => profile}, socket) do
    {:noreply, assign(socket, profile: profile)}
  end

  # ── Examples (source extracted at compile time) ───────────────────

  defp example_basic(assigns) do
    ~H"""
    <.menubar id="basic-menubar">
      <.menubar_menu>
        <.menubar_trigger>File</.menubar_trigger>
        <.menubar_content>
          <.menubar_item>
            New Tab <.menubar_shortcut>⌘T</.menubar_shortcut>
          </.menubar_item>
          <.menubar_item>
            New Window <.menubar_shortcut>⌘N</.menubar_shortcut>
          </.menubar_item>
          <.menubar_item disabled>
            New Incognito Window
          </.menubar_item>
          <.menubar_separator />
          <.menubar_item>
            Print... <.menubar_shortcut>⌘P</.menubar_shortcut>
          </.menubar_item>
        </.menubar_content>
      </.menubar_menu>

      <.menubar_menu>
        <.menubar_trigger>Edit</.menubar_trigger>
        <.menubar_content>
          <.menubar_item>
            Undo <.menubar_shortcut>⌘Z</.menubar_shortcut>
          </.menubar_item>
          <.menubar_item>
            Redo <.menubar_shortcut>⇧⌘Z</.menubar_shortcut>
          </.menubar_item>
          <.menubar_separator />
          <.menubar_item>
            Cut <.menubar_shortcut>⌘X</.menubar_shortcut>
          </.menubar_item>
          <.menubar_item>
            Copy <.menubar_shortcut>⌘C</.menubar_shortcut>
          </.menubar_item>
          <.menubar_item>
            Paste <.menubar_shortcut>⌘V</.menubar_shortcut>
          </.menubar_item>
        </.menubar_content>
      </.menubar_menu>
    </.menubar>
    """
  end

  defp example_full(assigns) do
    ~H"""
    <.menubar id="full-menubar">
      <.menubar_menu>
        <.menubar_trigger>File</.menubar_trigger>
        <.menubar_content>
          <.menubar_item>
            New Tab <.menubar_shortcut>⌘T</.menubar_shortcut>
          </.menubar_item>
          <.menubar_item>
            New Window <.menubar_shortcut>⌘N</.menubar_shortcut>
          </.menubar_item>
          <.menubar_item disabled>New Incognito Window</.menubar_item>
          <.menubar_separator />
          <.menubar_sub>
            <.menubar_sub_trigger>Share</.menubar_sub_trigger>
            <.menubar_sub_content>
              <.menubar_item>Email Link</.menubar_item>
              <.menubar_item>Messages</.menubar_item>
              <.menubar_item>Notes</.menubar_item>
            </.menubar_sub_content>
          </.menubar_sub>
          <.menubar_separator />
          <.menubar_item>
            Print... <.menubar_shortcut>⌘P</.menubar_shortcut>
          </.menubar_item>
        </.menubar_content>
      </.menubar_menu>

      <.menubar_menu>
        <.menubar_trigger>Edit</.menubar_trigger>
        <.menubar_content>
          <.menubar_item>
            Undo <.menubar_shortcut>⌘Z</.menubar_shortcut>
          </.menubar_item>
          <.menubar_item>
            Redo <.menubar_shortcut>⇧⌘Z</.menubar_shortcut>
          </.menubar_item>
          <.menubar_separator />
          <.menubar_sub>
            <.menubar_sub_trigger>Find</.menubar_sub_trigger>
            <.menubar_sub_content>
              <.menubar_item>Search the web</.menubar_item>
              <.menubar_separator />
              <.menubar_item>Find...</.menubar_item>
              <.menubar_item>Find Next</.menubar_item>
              <.menubar_item>Find Previous</.menubar_item>
            </.menubar_sub_content>
          </.menubar_sub>
          <.menubar_separator />
          <.menubar_item>Cut</.menubar_item>
          <.menubar_item>Copy</.menubar_item>
          <.menubar_item>Paste</.menubar_item>
        </.menubar_content>
      </.menubar_menu>

      <.menubar_menu>
        <.menubar_trigger>View</.menubar_trigger>
        <.menubar_content>
          <.menubar_checkbox_item checked={@show_bookmarks_bar} phx-click="toggle-bookmarks-bar">
            Always Show Bookmarks Bar
          </.menubar_checkbox_item>
          <.menubar_checkbox_item checked={@show_full_urls} phx-click="toggle-full-urls">
            Always Show Full URLs
          </.menubar_checkbox_item>
          <.menubar_separator />
          <.menubar_item inset>
            Reload <.menubar_shortcut>⌘R</.menubar_shortcut>
          </.menubar_item>
          <.menubar_item inset disabled>
            Force Reload <.menubar_shortcut>⇧⌘R</.menubar_shortcut>
          </.menubar_item>
          <.menubar_separator />
          <.menubar_item inset>Toggle Fullscreen</.menubar_item>
          <.menubar_item inset>Hide Sidebar</.menubar_item>
        </.menubar_content>
      </.menubar_menu>

      <.menubar_menu>
        <.menubar_trigger>Profiles</.menubar_trigger>
        <.menubar_content>
          <.menubar_radio_group>
            <.menubar_radio_item
              :for={name <- ~w(benoit pedro colm)}
              checked={@profile == name}
              phx-click="set-profile"
              phx-value-val={name}
            >
              {String.capitalize(name)}
            </.menubar_radio_item>
          </.menubar_radio_group>
          <.menubar_separator />
          <.menubar_item inset>Edit...</.menubar_item>
          <.menubar_separator />
          <.menubar_item inset>Add Profile...</.menubar_item>
        </.menubar_content>
      </.menubar_menu>
    </.menubar>
    """
  end

  defp example_icons(assigns) do
    ~H"""
    <.menubar id="icon-menubar">
      <.menubar_menu>
        <.menubar_trigger>File</.menubar_trigger>
        <.menubar_content>
          <.menubar_item>
            <.icon name="hero-document-plus-micro" /> New File
          </.menubar_item>
          <.menubar_item>
            <.icon name="hero-folder-open-micro" /> Open...
          </.menubar_item>
          <.menubar_item>
            <.icon name="hero-arrow-down-tray-micro" /> Save
            <.menubar_shortcut>⌘S</.menubar_shortcut>
          </.menubar_item>
          <.menubar_separator />
          <.menubar_item>
            <.icon name="hero-printer-micro" /> Print...
            <.menubar_shortcut>⌘P</.menubar_shortcut>
          </.menubar_item>
        </.menubar_content>
      </.menubar_menu>

      <.menubar_menu>
        <.menubar_trigger>Edit</.menubar_trigger>
        <.menubar_content>
          <.menubar_item>
            <.icon name="hero-arrow-uturn-left-micro" /> Undo
            <.menubar_shortcut>⌘Z</.menubar_shortcut>
          </.menubar_item>
          <.menubar_item>
            <.icon name="hero-arrow-uturn-right-micro" /> Redo
            <.menubar_shortcut>⇧⌘Z</.menubar_shortcut>
          </.menubar_item>
          <.menubar_separator />
          <.menubar_item>
            <.icon name="hero-scissors-micro" /> Cut
            <.menubar_shortcut>⌘X</.menubar_shortcut>
          </.menubar_item>
          <.menubar_item>
            <.icon name="hero-clipboard-document-micro" /> Copy
            <.menubar_shortcut>⌘C</.menubar_shortcut>
          </.menubar_item>
          <.menubar_item>
            <.icon name="hero-clipboard-micro" /> Paste
            <.menubar_shortcut>⌘V</.menubar_shortcut>
          </.menubar_item>
        </.menubar_content>
      </.menubar_menu>
    </.menubar>
    """
  end

  defp example_disabled(assigns) do
    ~H"""
    <.menubar id="disabled-menubar">
      <.menubar_menu>
        <.menubar_trigger>File</.menubar_trigger>
        <.menubar_content>
          <.menubar_item>New Tab</.menubar_item>
          <.menubar_item>New Window</.menubar_item>
          <.menubar_item disabled>New Incognito Window</.menubar_item>
          <.menubar_separator />
          <.menubar_item disabled>Share...</.menubar_item>
          <.menubar_item>Print...</.menubar_item>
        </.menubar_content>
      </.menubar_menu>

      <.menubar_menu>
        <.menubar_trigger>Edit</.menubar_trigger>
        <.menubar_content>
          <.menubar_item>Undo</.menubar_item>
          <.menubar_item disabled>Redo</.menubar_item>
          <.menubar_separator />
          <.menubar_item>Cut</.menubar_item>
          <.menubar_item>Copy</.menubar_item>
          <.menubar_item disabled>Paste</.menubar_item>
        </.menubar_content>
      </.menubar_menu>
    </.menubar>
    """
  end

  # ── Render ────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Menubar" storybook="/storybook/menubar">
        A horizontal menu bar (File/Edit/View pattern) with multi-menu coordination,
        hover-to-switch, cross-menu keyboard navigation, sub-menus, and full ARIA
        menubar semantics.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Basic --%>
      <.demo_section title="Basic" code={showcase_source(:example_basic)}>
        <:description>
          A simple menubar with File and Edit menus. Click a trigger or press
          Enter/ArrowDown to open. Arrow keys navigate between triggers and
          between menus. Hover switches menus when one is already open.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_basic(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Full Demo --%>
      <.demo_section title="Full Demo" code={showcase_source(:example_full)}>
        <:description>
          Four menus: File (sub-menu "Share"), Edit (sub-menu "Find"), View
          (checkbox items), Profiles (radio group). Mirrors the shadcn official demo.
        </:description>

        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_full(assigns)}

            <.state_display
              label="Server state"
              value={"bookmarks_bar=#{@show_bookmarks_bar}, full_urls=#{@show_full_urls}, profile=#{@profile}"}
            />
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: With Icons --%>
      <.demo_section title="With Icons" code={showcase_source(:example_icons)}>
        <:description>
          Menu items with leading hero icons.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_icons(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 4: Disabled Items --%>
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
    </div>
    """
  end
end
