defmodule PhxShadcnDevWeb.ShowcaseLive.Sheet do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  alias PhxShadcn.Components.Sheet, as: SheetHelpers

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Sheet",
       # Server-controlled demo
       show_server_sheet: false,
       server_result: nil
     )}
  end

  # ── Server-controlled events ────────────────────────────────────────

  @impl true
  def handle_event("open-server-sheet", _params, socket) do
    {:noreply, assign(socket, show_server_sheet: true)}
  end

  def handle_event("close-server-sheet", _params, socket) do
    {:noreply, assign(socket, show_server_sheet: false)}
  end

  def handle_event("save-server-sheet", _params, socket) do
    {:noreply, assign(socket, show_server_sheet: false, server_result: "Settings saved!")}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_basic(assigns) do
    ~H"""
    <.button phx-click={SheetHelpers.show_sheet("basic-sheet")}>
      Open Sheet
    </.button>

    <.sheet id="basic-sheet" on_cancel={SheetHelpers.hide_sheet("basic-sheet")}>
      <.sheet_header>
        <.sheet_title id="basic-sheet-title">Edit profile</.sheet_title>
        <.sheet_description id="basic-sheet-description">
          Make changes to your profile here. Click save when you're done.
        </.sheet_description>
      </.sheet_header>
      <div class="grid gap-4 px-4 py-4">
        <div class="grid grid-cols-4 items-center gap-4">
          <.label class="text-right">Name</.label>
          <.input name="name" value="Pedro Duarte" class="col-span-3" />
        </div>
        <div class="grid grid-cols-4 items-center gap-4">
          <.label class="text-right">Username</.label>
          <.input name="username" value="@peduarte" class="col-span-3" />
        </div>
      </div>
      <.sheet_footer>
        <.button phx-click={SheetHelpers.hide_sheet("basic-sheet")}>Save changes</.button>
      </.sheet_footer>
    </.sheet>
    """
  end

  defp example_all_sides(assigns) do
    ~H"""
    <.button :for={side <- ~w(top right bottom left)a} variant="outline" phx-click={SheetHelpers.show_sheet("side-#{side}")}>
      {side |> Atom.to_string() |> String.capitalize()}
    </.button>

    <.sheet :for={side <- ~w(top right bottom left)a} id={"side-#{side}"} side={side} on_cancel={SheetHelpers.hide_sheet("side-#{side}")}>
      <.sheet_header>
        <.sheet_title id={"side-#{side}-title"}>
          {side |> Atom.to_string() |> String.capitalize()} Sheet
        </.sheet_title>
        <.sheet_description id={"side-#{side}-description"}>
          This sheet slides in from the {Atom.to_string(side)}.
        </.sheet_description>
      </.sheet_header>
      <div class="p-4">
        <p class="text-sm text-muted-foreground">Sheet content goes here.</p>
      </div>
      <.sheet_footer>
        <.sheet_close on_cancel={SheetHelpers.hide_sheet("side-#{side}")}>
          <.button variant="outline">Close</.button>
        </.sheet_close>
      </.sheet_footer>
    </.sheet>
    """
  end

  defp example_handle(assigns) do
    ~H"""
    <.button variant="outline" phx-click={SheetHelpers.show_sheet("drawer-sheet")}>
      Open Drawer
    </.button>

    <.sheet id="drawer-sheet" side={:bottom} handle on_cancel={SheetHelpers.hide_sheet("drawer-sheet")}>
      <.sheet_header>
        <.sheet_title id="drawer-sheet-title">Move Goal</.sheet_title>
        <.sheet_description id="drawer-sheet-description">
          Set your daily activity goal.
        </.sheet_description>
      </.sheet_header>
      <div class="p-4 pb-0">
        <div class="flex items-center justify-center space-x-2">
          <div class="flex-1 text-center">
            <div class="text-7xl font-bold tracking-tighter">350</div>
            <div class="text-[0.70rem] uppercase text-muted-foreground">Calories/day</div>
          </div>
        </div>
      </div>
      <.sheet_footer>
        <.button phx-click={SheetHelpers.hide_sheet("drawer-sheet")}>Submit</.button>
      </.sheet_footer>
    </.sheet>
    """
  end

  defp example_server_controlled(assigns) do
    ~H"""
    <.button phx-click="open-server-sheet">Open Settings</.button>

    <div :if={@server_result} class="text-sm text-muted-foreground">
      Result: {@server_result}
    </div>

    <.sheet :if={@show_server_sheet} id="server-sheet" show on_cancel={JS.push("close-server-sheet")}>
      <.sheet_header>
        <.sheet_title id="server-sheet-title">Settings</.sheet_title>
        <.sheet_description id="server-sheet-description">
          Manage your application settings.
        </.sheet_description>
      </.sheet_header>
      <div class="p-4">
        <p class="text-sm text-muted-foreground">Settings content would go here.</p>
      </div>
      <.sheet_footer>
        <.sheet_close on_cancel={JS.push("close-server-sheet")}>
          <.button variant="outline">Cancel</.button>
        </.sheet_close>
        <.button phx-click="save-server-sheet">Save</.button>
      </.sheet_footer>
    </.sheet>
    """
  end

  # ── Render ──────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Sheet" storybook="/storybook/sheet">
        A panel that slides in from the edge of the screen. Extends the
        <.inline_code>&lt;dialog&gt;</.inline_code> pattern used by Dialog and AlertDialog.
        Unifies shadcn Sheet + Drawer into one component.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Basic (client-only, right side) --%>
      <.demo_section title="Basic (Client-only)" code={showcase_source(:example_basic)}>
        <:description>
          Right-side sheet with an edit profile form. Uses
          <.inline_code>show_sheet/1</.inline_code> and <.inline_code>hide_sheet/1</.inline_code> helpers.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_basic(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: All Sides --%>
      <.demo_section title="All Sides" code={showcase_source(:example_all_sides)}>
        <:description>
          Sheets can slide in from any edge. Use the <.inline_code>side</.inline_code> attribute.
        </:description>

        <.card>
          <.card_content class="pt-6 flex flex-wrap gap-3">
            {example_all_sides(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: Bottom with Handle (Drawer style) --%>
      <.demo_section title="With Handle (Drawer Style)" code={showcase_source(:example_handle)}>
        <:description>
          Bottom sheet with <.inline_code>handle</.inline_code> attribute for a visual drag handle bar.
          This covers the Drawer use case.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_handle(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 4: Server-controlled --%>
      <.demo_section title="Server-controlled" code={showcase_source(:example_server_controlled)}>
        <:description>
          Server opens and closes the sheet. Uses the
          <.inline_code>:if</.inline_code> + <.inline_code>show</.inline_code> pattern.
        </:description>

        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_server_controlled(assigns)}
          </.card_content>
        </.card>

        <.state_display label="Server state" value={"show=#{inspect(@show_server_sheet)}, result=#{inspect(@server_result)}"} />
      </.demo_section>
    </div>
    """
  end
end
