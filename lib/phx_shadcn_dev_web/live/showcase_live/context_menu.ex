defmodule PhxShadcnDevWeb.ShowcaseLive.ContextMenu do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "ContextMenu",
       # Checkbox items demo
       show_bookmarks: true,
       show_full_urls: false,
       # Radio group demo
       person: "Pedro"
     )}
  end

  # ── Checkbox item events ──────────────────────────────────────────

  @impl true
  def handle_event("toggle-bookmarks", _params, socket) do
    {:noreply, assign(socket, show_bookmarks: !socket.assigns.show_bookmarks)}
  end

  def handle_event("toggle-full-urls", _params, socket) do
    {:noreply, assign(socket, show_full_urls: !socket.assigns.show_full_urls)}
  end

  # ── Radio group events ────────────────────────────────────────────

  def handle_event("set-person", %{"val" => person}, socket) do
    {:noreply, assign(socket, person: person)}
  end

  # ── Examples (source extracted at compile time) ───────────────────

  defp example_basic(assigns) do
    ~H"""
    <.context_menu id="basic-ctx">
      <.context_menu_trigger>
        <div class="flex h-[150px] w-[300px] items-center justify-center rounded-md border border-dashed text-sm">
          Right click here
        </div>
      </.context_menu_trigger>
      <.context_menu_content class="w-64">
        <.context_menu_item>
          Back
          <.context_menu_shortcut>⌘[</.context_menu_shortcut>
        </.context_menu_item>
        <.context_menu_item>
          Forward
          <.context_menu_shortcut>⌘]</.context_menu_shortcut>
        </.context_menu_item>
        <.context_menu_item>
          Reload
          <.context_menu_shortcut>⌘R</.context_menu_shortcut>
        </.context_menu_item>
        <.context_menu_separator />
        <.context_menu_item>
          View Page Source
          <.context_menu_shortcut>⌘U</.context_menu_shortcut>
        </.context_menu_item>
        <.context_menu_item>
          Inspect
          <.context_menu_shortcut>⌘⇧I</.context_menu_shortcut>
        </.context_menu_item>
      </.context_menu_content>
    </.context_menu>
    """
  end

  defp example_full(assigns) do
    ~H"""
    <.context_menu id="full-ctx">
      <.context_menu_trigger>
        <div class="flex h-[150px] w-[300px] items-center justify-center rounded-md border border-dashed text-sm">
          Right click here
        </div>
      </.context_menu_trigger>
      <.context_menu_content class="w-64">
        <.context_menu_item>
          Back
          <.context_menu_shortcut>⌘[</.context_menu_shortcut>
        </.context_menu_item>
        <.context_menu_item>
          Forward
          <.context_menu_shortcut>⌘]</.context_menu_shortcut>
        </.context_menu_item>
        <.context_menu_item>
          Reload
          <.context_menu_shortcut>⌘R</.context_menu_shortcut>
        </.context_menu_item>
        <.context_menu_sub>
          <.context_menu_sub_trigger>More Tools</.context_menu_sub_trigger>
          <.context_menu_sub_content>
            <.context_menu_item>
              Save Page As...
              <.context_menu_shortcut>⇧⌘S</.context_menu_shortcut>
            </.context_menu_item>
            <.context_menu_item>Create Shortcut...</.context_menu_item>
            <.context_menu_item>Name Window...</.context_menu_item>
            <.context_menu_separator />
            <.context_menu_item>Developer Tools</.context_menu_item>
          </.context_menu_sub_content>
        </.context_menu_sub>
        <.context_menu_separator />
        <.context_menu_checkbox_item checked={@show_bookmarks} phx-click="toggle-bookmarks">
          Show Bookmarks Bar
          <.context_menu_shortcut>⌘⇧B</.context_menu_shortcut>
        </.context_menu_checkbox_item>
        <.context_menu_checkbox_item checked={@show_full_urls} phx-click="toggle-full-urls">
          Show Full URLs
        </.context_menu_checkbox_item>
        <.context_menu_separator />
        <.context_menu_label inset>People</.context_menu_label>
        <.context_menu_radio_group>
          <.context_menu_radio_item
            :for={name <- ~w(Pedro Colm)}
            checked={@person == name}
            phx-click="set-person"
            phx-value-val={name}
          >
            {name}
          </.context_menu_radio_item>
        </.context_menu_radio_group>
      </.context_menu_content>
    </.context_menu>
    """
  end

  defp example_icons(assigns) do
    ~H"""
    <.context_menu id="icons-ctx">
      <.context_menu_trigger>
        <div class="flex h-[150px] w-[300px] items-center justify-center rounded-md border border-dashed text-sm">
          Right click here
        </div>
      </.context_menu_trigger>
      <.context_menu_content class="w-64">
        <.context_menu_group>
          <.context_menu_item>
            <.icon name="hero-user-micro" />
            Profile
            <.context_menu_shortcut>⇧⌘P</.context_menu_shortcut>
          </.context_menu_item>
          <.context_menu_item>
            <.icon name="hero-credit-card-micro" />
            Billing
            <.context_menu_shortcut>⌘B</.context_menu_shortcut>
          </.context_menu_item>
          <.context_menu_item>
            <.icon name="hero-cog-6-tooth-micro" />
            Settings
            <.context_menu_shortcut>⌘S</.context_menu_shortcut>
          </.context_menu_item>
        </.context_menu_group>
        <.context_menu_separator />
        <.context_menu_item>
          <.icon name="hero-arrow-right-start-on-rectangle-micro" />
          Log out
          <.context_menu_shortcut>⇧⌘Q</.context_menu_shortcut>
        </.context_menu_item>
      </.context_menu_content>
    </.context_menu>
    """
  end

  defp example_destructive(assigns) do
    ~H"""
    <.context_menu id="destructive-ctx">
      <.context_menu_trigger>
        <div class="flex h-[150px] w-[300px] items-center justify-center rounded-md border border-dashed text-sm">
          Right click here
        </div>
      </.context_menu_trigger>
      <.context_menu_content class="w-64">
        <.context_menu_label>Account</.context_menu_label>
        <.context_menu_separator />
        <.context_menu_item>Profile</.context_menu_item>
        <.context_menu_item>Settings</.context_menu_item>
        <.context_menu_separator />
        <.context_menu_item variant="destructive">
          <.icon name="hero-trash-micro" />
          Delete Account
        </.context_menu_item>
      </.context_menu_content>
    </.context_menu>
    """
  end

  defp example_disabled(assigns) do
    ~H"""
    <.context_menu id="disabled-ctx">
      <.context_menu_trigger>
        <div class="flex h-[150px] w-[300px] items-center justify-center rounded-md border border-dashed text-sm">
          Right click here
        </div>
      </.context_menu_trigger>
      <.context_menu_content class="w-64">
        <.context_menu_item>Undo</.context_menu_item>
        <.context_menu_item>Redo</.context_menu_item>
        <.context_menu_separator />
        <.context_menu_item>Cut</.context_menu_item>
        <.context_menu_item>Copy</.context_menu_item>
        <.context_menu_item disabled>Paste</.context_menu_item>
        <.context_menu_separator />
        <.context_menu_item disabled>Delete</.context_menu_item>
        <.context_menu_item>Select All</.context_menu_item>
      </.context_menu_content>
    </.context_menu>
    """
  end

  # ── Render ────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="ContextMenu" storybook="/storybook/context_menu">
        A right-click triggered floating menu with cursor-anchored positioning,
        keyboard navigation, typeahead, checkbox/radio items, and ARIA menu semantics.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Basic --%>
      <.demo_section title="Basic" code={showcase_source(:example_basic)}>
        <:description>
          Right-click the dashed area to open a context menu with navigation items and shortcuts.
        </:description>

        <.card>
          <.card_content class="pt-6 flex justify-center">
            {example_basic(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Full demo (sub-menus, checkboxes, radio) --%>
      <.demo_section title="Full Demo" code={showcase_source(:example_full)}>
        <:description>
          Sub-menus, checkbox items (Show Bookmarks, Show Full URLs),
          and a radio group (People: Pedro/Colm). Mirrors shadcn's official demo.
        </:description>

        <.card>
          <.card_content class="pt-6 space-y-4 flex flex-col items-center">
            {example_full(assigns)}

            <.state_display
              label="Server state"
              value={"bookmarks=#{@show_bookmarks}, full_urls=#{@show_full_urls}, person=#{@person}"}
            />
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: With Icons --%>
      <.demo_section title="With Icons" code={showcase_source(:example_icons)}>
        <:description>
          Items with leading icons.
        </:description>

        <.card>
          <.card_content class="pt-6 flex justify-center">
            {example_icons(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 4: Destructive --%>
      <.demo_section title="Destructive Item" code={showcase_source(:example_destructive)}>
        <:description>
          Use variant="destructive" for dangerous actions.
        </:description>

        <.card>
          <.card_content class="pt-6 flex justify-center">
            {example_destructive(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 5: Disabled Items --%>
      <.demo_section title="Disabled Items" code={showcase_source(:example_disabled)}>
        <:description>
          Disabled items are visually dimmed and skipped by keyboard navigation.
        </:description>

        <.card>
          <.card_content class="pt-6 flex justify-center">
            {example_disabled(assigns)}
          </.card_content>
        </.card>
      </.demo_section>
    </div>
    """
  end
end
