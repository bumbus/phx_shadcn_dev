defmodule PhxShadcnDevWeb.ShowcaseLive.Popover do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Popover",
       show_server_pop: false,
       server_result: nil
     )}
  end

  # ── Server-controlled events ────────────────────────────────────────

  @impl true
  def handle_event("open-server-pop", _params, socket) do
    {:noreply, assign(socket, show_server_pop: true)}
  end

  def handle_event("close-server-pop", _params, socket) do
    {:noreply, assign(socket, show_server_pop: false)}
  end

  def handle_event("save-server-pop", _params, socket) do
    {:noreply, assign(socket, show_server_pop: false, server_result: "Settings saved!")}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_basic(assigns) do
    ~H"""
    <.popover id="basic-pop">
      <.popover_trigger>
        <.button variant="outline">Open popover</.button>
      </.popover_trigger>
      <.popover_content>
        <.popover_header class="mb-4">
          <.popover_title>Dimensions</.popover_title>
          <.popover_description>Set the dimensions for the layer.</.popover_description>
        </.popover_header>
        <div class="grid gap-2">
          <div class="grid grid-cols-3 items-center gap-4">
            <.label>Width</.label>
            <.input name="width" value="100%" class="col-span-2 h-8" />
          </div>
          <div class="grid grid-cols-3 items-center gap-4">
            <.label>Max. width</.label>
            <.input name="max-width" value="300px" class="col-span-2 h-8" />
          </div>
          <div class="grid grid-cols-3 items-center gap-4">
            <.label>Height</.label>
            <.input name="height" value="25px" class="col-span-2 h-8" />
          </div>
          <div class="grid grid-cols-3 items-center gap-4">
            <.label>Max. height</.label>
            <.input name="max-height" value="none" class="col-span-2 h-8" />
          </div>
        </div>
      </.popover_content>
    </.popover>
    """
  end

  defp example_alignments(assigns) do
    ~H"""
    <.popover :for={align <- ~w(start center end)} id={"align-#{align}"}>
      <.popover_trigger>
        <.button variant="outline">{String.capitalize(align)}</.button>
      </.popover_trigger>
      <.popover_content align={align}>
        <.popover_header>
          <.popover_title>Align: {align}</.popover_title>
        </.popover_header>
        <p class="mt-2 text-sm text-muted-foreground">
          This popover is aligned to the {align}.
        </p>
      </.popover_content>
    </.popover>
    """
  end

  defp example_side_placement(assigns) do
    ~H"""
    <.popover :for={side <- ~w(top right bottom left)} id={"side-#{side}"}>
      <.popover_trigger>
        <.button variant="outline">{String.capitalize(side)}</.button>
      </.popover_trigger>
      <.popover_content side={side}>
        <.popover_header>
          <.popover_title>Side: {side}</.popover_title>
        </.popover_header>
        <p class="mt-2 text-sm text-muted-foreground">
          This popover opens to the {side}.
        </p>
      </.popover_content>
    </.popover>
    """
  end

  defp example_server_controlled(assigns) do
    ~H"""
    <.button phx-click="open-server-pop">Open Settings</.button>

    <div :if={@server_result} class="text-sm text-muted-foreground">
      Result: {@server_result}
    </div>
    """
  end

  # ── Render ──────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Popover" storybook="/storybook/popover">
        A floating panel anchored to a trigger element. Uses Floating UI for
        positioning with automatic flip and shift when near viewport edges.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Basic (client-only) --%>
      <.demo_section title="Basic (Client-only)" code={showcase_source(:example_basic)}>
        <:description>
          Click the trigger to toggle the popover. Click outside or press Escape to dismiss.
          This is the classic shadcn "Dimensions" example.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_basic(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Alignments --%>
      <.demo_section title="Alignments" code={showcase_source(:example_alignments)}>
        <:description>
          Use <.inline_code>align</.inline_code> to control horizontal alignment:
          <.inline_code>"start"</.inline_code>, <.inline_code>"center"</.inline_code> (default),
          <.inline_code>"end"</.inline_code>.
        </:description>

        <.card>
          <.card_content class="pt-6 flex flex-wrap gap-3">
            {example_alignments(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: Side Placement --%>
      <.demo_section title="Side Placement" code={showcase_source(:example_side_placement)}>
        <:description>
          Use <.inline_code>side</.inline_code> to place the popover on any side of the trigger.
          The popover will flip to the opposite side if there isn't enough space.
        </:description>

        <.card>
          <.card_content class="pt-6 flex flex-wrap justify-center gap-3">
            {example_side_placement(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 4: Server-controlled --%>
      <.demo_section title="Server-controlled" code={showcase_source(:example_server_controlled)}>
        <:description>
          Server opens and closes the popover. Uses the
          <.inline_code>:if</.inline_code> + <.inline_code>show</.inline_code> pattern.
        </:description>

        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_server_controlled(assigns)}
          </.card_content>
        </.card>

        <.popover :if={@show_server_pop} id="server-pop" show on_open_change={JS.push("close-server-pop")}>
          <.popover_trigger>
            <.button variant="outline">Settings</.button>
          </.popover_trigger>
          <.popover_content>
            <.popover_header class="mb-4">
              <.popover_title>Settings</.popover_title>
              <.popover_description>Manage your preferences.</.popover_description>
            </.popover_header>
            <div class="flex justify-end gap-2">
              <.popover_close on_open_change={JS.push("close-server-pop")}>
                <.button variant="outline" size="sm">Cancel</.button>
              </.popover_close>
              <.button size="sm" phx-click="save-server-pop">Save</.button>
            </div>
          </.popover_content>
        </.popover>

        <.state_display label="Server state" value={"show=#{inspect(@show_server_pop)}, result=#{inspect(@server_result)}"} />
      </.demo_section>
    </div>
    """
  end
end
