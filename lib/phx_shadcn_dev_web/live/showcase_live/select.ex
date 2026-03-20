defmodule PhxShadcnDevWeb.ShowcaseLive.Select do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  alias PhxShadcnDev.Schemas.Settings

  @impl true
  def mount(_params, _session, socket) do
    settings = %Settings{}
    form = settings |> Settings.changeset(%{}) |> to_form(as: "settings")

    {:ok,
     assign(socket,
       page_title: "Select",
       settings: settings,
       form: form,
       # Server-controlled demo
       server_value: "banana",
       # Hybrid demo
       hybrid_value: nil
     )}
  end

  # ── Events ──────────────────────────────────────────────────────────

  @impl true
  def handle_event("validate", %{"settings" => params}, socket) do
    changeset =
      socket.assigns.settings
      |> Settings.changeset(params)
      |> Map.put(:action, :validate)

    form = to_form(changeset, as: "settings")
    {:noreply, assign(socket, form: form)}
  end

  def handle_event("save", %{"settings" => _params}, socket) do
    {:noreply, socket}
  end

  def handle_event("set-server-fruit", %{"val" => value}, socket) do
    {:noreply, assign(socket, server_value: value)}
  end

  def handle_event("set-server-fruit", %{"value" => value}, socket) do
    {:noreply, assign(socket, server_value: value)}
  end

  def handle_event("hybrid-change", %{"value" => value}, socket) do
    {:noreply, assign(socket, hybrid_value: value)}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_basic(assigns) do
    ~H"""
    <.select id="basic-select" default_value="banana">
      <.select_trigger>
        <.select_value placeholder="Pick a fruit" />
      </.select_trigger>
      <.select_content>
        <.select_item value="apple">Apple</.select_item>
        <.select_item value="banana">Banana</.select_item>
        <.select_item value="blueberry">Blueberry</.select_item>
        <.select_item value="cherry">Cherry</.select_item>
        <.select_item value="grape">Grape</.select_item>
        <.select_item value="pineapple">Pineapple</.select_item>
      </.select_content>
    </.select>
    """
  end

  defp example_with_groups(assigns) do
    ~H"""
    <.select id="grouped-select">
      <.select_trigger class="w-[200px]">
        <.select_value placeholder="Select a fruit" />
      </.select_trigger>
      <.select_content>
        <.select_group>
          <.select_label>Fruits</.select_label>
          <.select_item value="apple">Apple</.select_item>
          <.select_item value="banana">Banana</.select_item>
          <.select_item value="blueberry">Blueberry</.select_item>
        </.select_group>
        <.select_separator />
        <.select_group>
          <.select_label>Vegetables</.select_label>
          <.select_item value="carrot">Carrot</.select_item>
          <.select_item value="broccoli">Broccoli</.select_item>
          <.select_item value="spinach">Spinach</.select_item>
        </.select_group>
      </.select_content>
    </.select>
    """
  end

  defp example_scrollable(assigns) do
    ~H"""
    <.select id="timezone-select">
      <.select_trigger class="w-[240px]">
        <.select_value placeholder="Select a timezone" />
      </.select_trigger>
      <.select_content>
        <.select_group>
          <.select_label>North America</.select_label>
          <.select_item value="est">Eastern Standard Time (EST)</.select_item>
          <.select_item value="cst">Central Standard Time (CST)</.select_item>
          <.select_item value="mst">Mountain Standard Time (MST)</.select_item>
          <.select_item value="pst">Pacific Standard Time (PST)</.select_item>
          <.select_item value="akst">Alaska Standard Time (AKST)</.select_item>
          <.select_item value="hst">Hawaii Standard Time (HST)</.select_item>
        </.select_group>
        <.select_separator />
        <.select_group>
          <.select_label>Europe & Africa</.select_label>
          <.select_item value="gmt">Greenwich Mean Time (GMT)</.select_item>
          <.select_item value="cet">Central European Time (CET)</.select_item>
          <.select_item value="eet">Eastern European Time (EET)</.select_item>
          <.select_item value="west">Western European Summer Time (WEST)</.select_item>
          <.select_item value="cat">Central Africa Time (CAT)</.select_item>
          <.select_item value="eat">East Africa Time (EAT)</.select_item>
        </.select_group>
        <.select_separator />
        <.select_group>
          <.select_label>Asia</.select_label>
          <.select_item value="msk">Moscow Standard Time (MSK)</.select_item>
          <.select_item value="ist">India Standard Time (IST)</.select_item>
          <.select_item value="cst_china">China Standard Time (CST)</.select_item>
          <.select_item value="jst">Japan Standard Time (JST)</.select_item>
          <.select_item value="kst">Korea Standard Time (KST)</.select_item>
          <.select_item value="ist_indonesia">Indonesia Central Time (WITA)</.select_item>
        </.select_group>
        <.select_separator />
        <.select_group>
          <.select_label>Australia & Pacific</.select_label>
          <.select_item value="awst">Australian Western Standard Time (AWST)</.select_item>
          <.select_item value="acst">Australian Central Standard Time (ACST)</.select_item>
          <.select_item value="aest">Australian Eastern Standard Time (AEST)</.select_item>
          <.select_item value="nzst">New Zealand Standard Time (NZST)</.select_item>
          <.select_item value="fjt">Fiji Time (FJT)</.select_item>
        </.select_group>
      </.select_content>
    </.select>
    """
  end

  defp example_disabled(assigns) do
    ~H"""
    <.select id="disabled-select">
      <.select_trigger class="w-[200px]">
        <.select_value placeholder="Select a fruit" />
      </.select_trigger>
      <.select_content>
        <.select_item value="apple">Apple</.select_item>
        <.select_item value="banana" disabled>Banana (sold out)</.select_item>
        <.select_item value="cherry">Cherry</.select_item>
        <.select_item value="grape" disabled>Grape (sold out)</.select_item>
        <.select_item value="pineapple">Pineapple</.select_item>
      </.select_content>
    </.select>
    """
  end

  defp example_sizes(assigns) do
    ~H"""
    <div class="flex flex-wrap items-center gap-3">
      <.select id="size-default">
        <.select_trigger>
          <.select_value placeholder="Default" />
        </.select_trigger>
        <.select_content>
          <.select_item value="a">Option A</.select_item>
          <.select_item value="b">Option B</.select_item>
        </.select_content>
      </.select>

      <.select id="size-sm">
        <.select_trigger size="sm">
          <.select_value placeholder="Small" />
        </.select_trigger>
        <.select_content>
          <.select_item value="a">Option A</.select_item>
          <.select_item value="b">Option B</.select_item>
        </.select_content>
      </.select>
    </div>
    """
  end

  defp example_placement(assigns) do
    ~H"""
    <div class="flex flex-wrap justify-center gap-3">
      <.select :for={side <- ~w(top right bottom left)} id={"place-#{side}"}>
        <.select_trigger>
          <.select_value placeholder={String.capitalize(side)} />
        </.select_trigger>
        <.select_content side={side}>
          <.select_item value="one">Item One</.select_item>
          <.select_item value="two">Item Two</.select_item>
          <.select_item value="three">Item Three</.select_item>
        </.select_content>
      </.select>
    </div>
    """
  end

  defp example_form(assigns) do
    ~H"""
    <.form for={@form} phx-change="validate" phx-submit="save" class="space-y-4 max-w-xs">
      <.form_field
        field={@form[:framework]}
        label="Framework"
        type="select"
        prompt="Select a framework"
        options={[
          {"Next.js", "nextjs"},
          {"SvelteKit", "sveltekit"},
          {"Astro", "astro"},
          {"Nuxt", "nuxt"},
          {"Remix", "remix"},
          {"Phoenix", "phoenix"}
        ]}
        description="Your preferred web framework."
      />
      <.button type="submit">Submit</.button>
    </.form>
    """
  end

  defp example_server(assigns) do
    ~H"""
    <div class="space-y-4">
      <.select id="server-select" value={@server_value} on_value_change="set-server-fruit">
        <.select_trigger class="w-[200px]">
          <.select_value placeholder="Pick a fruit" />
        </.select_trigger>
        <.select_content>
          <.select_item value="apple">Apple</.select_item>
          <.select_item value="banana">Banana</.select_item>
          <.select_item value="cherry">Cherry</.select_item>
          <.select_item value="grape">Grape</.select_item>
        </.select_content>
      </.select>

      <div class="flex gap-2">
        <.button :for={fruit <- ~w(apple banana cherry grape)} variant="outline" size="sm" phx-click="set-server-fruit" phx-value-val={fruit}>
          {String.capitalize(fruit)}
        </.button>
      </div>
    </div>
    """
  end

  defp example_hybrid(assigns) do
    ~H"""
    <.select id="hybrid-select" on_value_change="hybrid-change">
      <.select_trigger class="w-[200px]">
        <.select_value placeholder="Pick a fruit" />
      </.select_trigger>
      <.select_content>
        <.select_item value="apple">Apple</.select_item>
        <.select_item value="banana">Banana</.select_item>
        <.select_item value="cherry">Cherry</.select_item>
      </.select_content>
    </.select>
    """
  end

  # ── Render ──────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Select" storybook="/storybook/select">
        A custom styled dropdown select with keyboard navigation, typeahead,
        checkmark indicators, and form integration.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Basic --%>
      <.demo_section title="Basic" code={showcase_source(:example_basic)}>
        <:description>
          A simple select with a default value. Click or press Enter/ArrowDown to open.
          Arrow keys navigate, Enter/Space select, Escape closes.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_basic(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: With Groups --%>
      <.demo_section title="With Groups" code={showcase_source(:example_with_groups)}>
        <:description>
          Grouped options with labels and separators.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_with_groups(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: Scrollable --%>
      <.demo_section title="Scrollable" code={showcase_source(:example_scrollable)}>
        <:description>
          A long list of grouped timezones showing overflow scrolling.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_scrollable(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 4: Disabled Items --%>
      <.demo_section title="Disabled Items" code={showcase_source(:example_disabled)}>
        <:description>
          Mix of enabled and disabled options. Disabled items are dimmed and skipped by keyboard.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_disabled(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 5: Sizes --%>
      <.demo_section title="Sizes" code={showcase_source(:example_sizes)}>
        <:description>
          Default and small trigger sizes.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_sizes(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 6: Placement --%>
      <.demo_section title="Placement" code={showcase_source(:example_placement)}>
        <:description>
          Different side positions. The popup flips if there isn't enough space.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_placement(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 7: Form Integration --%>
      <.demo_section title="Form Integration" code={showcase_source(:example_form)}>
        <:description>
          Inside a <.inline_code>&lt;.form&gt;</.inline_code> with <.inline_code>field</.inline_code>,
          showing <.inline_code>phx-change</.inline_code> round-trip via <.inline_code>form_field</.inline_code>.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_form(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 8: Server-controlled --%>
      <.demo_section title="Server-controlled" code={showcase_source(:example_server)}>
        <:description>
          Server owns the value via the <.inline_code>value</.inline_code> assign.
          Buttons below set the value from the server.
        </:description>

        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_server(assigns)}

            <.state_display label="Server state" value={"value=#{@server_value}"} />
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 9: Hybrid --%>
      <.demo_section title="Hybrid" code={showcase_source(:example_hybrid)}>
        <:description>
          Client instant selection + server notification via <.inline_code>on_value_change</.inline_code>.
        </:description>

        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_hybrid(assigns)}

            <.state_display
              label="Last server notification"
              value={if @hybrid_value, do: "value=#{@hybrid_value}", else: "(none)"}
            />
          </.card_content>
        </.card>
      </.demo_section>
    </div>
    """
  end
end
