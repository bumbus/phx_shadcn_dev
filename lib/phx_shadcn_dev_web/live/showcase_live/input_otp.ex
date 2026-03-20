defmodule PhxShadcnDevWeb.ShowcaseLive.InputOTP do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  alias PhxShadcnDev.Schemas.Settings

  @impl true
  def mount(_params, _session, socket) do
    settings = %Settings{}
    form = settings |> Settings.changeset(%{}) |> to_form(as: "settings")

    {:ok,
     assign(socket,
       page_title: "InputOTP",
       settings: settings,
       form: form,
       # Server-controlled demo
       server_value: "123",
       # Hybrid demo
       hybrid_events: []
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

  def handle_event("otp-value-change", %{"value" => value}, socket) do
    events = [{"value_change", value} | Enum.take(socket.assigns.hybrid_events, 4)]
    {:noreply, assign(socket, hybrid_events: events)}
  end

  def handle_event("otp-complete", %{"value" => value}, socket) do
    events = [{"complete", value} | Enum.take(socket.assigns.hybrid_events, 4)]
    {:noreply, assign(socket, hybrid_events: events)}
  end

  def handle_event("set-server-otp", %{"val" => value}, socket) do
    {:noreply, assign(socket, server_value: value)}
  end

  def handle_event("server-otp-change", %{"value" => value}, socket) do
    {:noreply, assign(socket, server_value: value)}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_default(assigns) do
    ~H"""
    <.input_otp id="otp-default" max_length={6}>
      <.input_otp_group>
        <.input_otp_slot :for={i <- 0..2} index={i} />
      </.input_otp_group>
      <.input_otp_separator />
      <.input_otp_group>
        <.input_otp_slot :for={i <- 3..5} index={i} />
      </.input_otp_group>
    </.input_otp>
    """
  end

  defp example_four_digit_pin(assigns) do
    ~H"""
    <.input_otp id="otp-pin" max_length={4}>
      <.input_otp_group>
        <.input_otp_slot :for={i <- 0..3} index={i} />
      </.input_otp_group>
    </.input_otp>
    """
  end

  defp example_alphanumeric(assigns) do
    ~H"""
    <.input_otp id="otp-alpha" max_length={6} pattern="alphanumeric">
      <.input_otp_group>
        <.input_otp_slot :for={i <- 0..5} index={i} />
      </.input_otp_group>
    </.input_otp>
    """
  end

  defp example_hex(assigns) do
    ~H"""
    <.input_otp id="otp-hex" max_length={8} pattern="[a-fA-F0-9]">
      <.input_otp_group>
        <.input_otp_slot :for={i <- 0..3} index={i} />
      </.input_otp_group>
      <.input_otp_separator />
      <.input_otp_group>
        <.input_otp_slot :for={i <- 4..7} index={i} />
      </.input_otp_group>
    </.input_otp>
    """
  end

  defp example_separators(assigns) do
    ~H"""
    <.input_otp id="otp-seps" max_length={6}>
      <.input_otp_group>
        <.input_otp_slot :for={i <- 0..1} index={i} />
      </.input_otp_group>
      <.input_otp_separator />
      <.input_otp_group>
        <.input_otp_slot :for={i <- 2..3} index={i} />
      </.input_otp_group>
      <.input_otp_separator />
      <.input_otp_group>
        <.input_otp_slot :for={i <- 4..5} index={i} />
      </.input_otp_group>
    </.input_otp>
    """
  end

  defp example_disabled(assigns) do
    ~H"""
    <.input_otp id="otp-disabled" max_length={4} default_value="1234" disabled>
      <.input_otp_group>
        <.input_otp_slot :for={i <- 0..3} index={i} />
      </.input_otp_group>
    </.input_otp>
    """
  end

  defp example_hybrid(assigns) do
    ~H"""
    <.input_otp id="otp-hybrid" max_length={6} on_value_change="otp-value-change" on_complete="otp-complete">
      <.input_otp_group>
        <.input_otp_slot :for={i <- 0..2} index={i} />
      </.input_otp_group>
      <.input_otp_separator />
      <.input_otp_group>
        <.input_otp_slot :for={i <- 3..5} index={i} />
      </.input_otp_group>
    </.input_otp>
    """
  end

  defp example_server(assigns) do
    ~H"""
    <div class="space-y-4">
      <.input_otp id="otp-server" max_length={6} value={@server_value} on_value_change="server-otp-change">
        <.input_otp_group>
          <.input_otp_slot :for={i <- 0..2} index={i} />
        </.input_otp_group>
        <.input_otp_separator />
        <.input_otp_group>
          <.input_otp_slot :for={i <- 3..5} index={i} />
        </.input_otp_group>
      </.input_otp>

      <div class="flex gap-2">
        <.button variant="outline" size="sm" phx-click="set-server-otp" phx-value-val="">Clear</.button>
        <.button variant="outline" size="sm" phx-click="set-server-otp" phx-value-val="123">123</.button>
        <.button variant="outline" size="sm" phx-click="set-server-otp" phx-value-val="123456">123456</.button>
        <.button variant="outline" size="sm" phx-click="set-server-otp" phx-value-val="999999">999999</.button>
      </div>
    </div>
    """
  end

  defp example_form(assigns) do
    ~H"""
    <.form for={@form} phx-change="validate" phx-submit="save" class="space-y-4 max-w-xs">
      <.form_field
        field={@form[:otp]}
        label="Verification Code"
        type="input_otp"
        max_length={6}
        description="Enter the 6-digit code sent to your phone."
      />
      <.button type="submit">Verify</.button>
    </.form>
    """
  end

  # ── Render ──────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="InputOTP" storybook="/storybook/input_otp">
        A segmented code input for OTP codes, PINs, and verification tokens.
        Each character gets its own visual slot with blinking caret animation.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Default --%>
      <.demo_section title="Default" code={showcase_source(:example_default)}>
        <:description>
          6-digit OTP with two groups of 3, separated by a dash. Type digits to fill slots left-to-right.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_default(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: 4-digit PIN --%>
      <.demo_section title="4-Digit PIN" code={showcase_source(:example_four_digit_pin)}>
        <:description>
          A simple 4-digit PIN input in a single group.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_four_digit_pin(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: Alphanumeric --%>
      <.demo_section title="Alphanumeric" code={showcase_source(:example_alphanumeric)}>
        <:description>
          Accepts letters and digits with <.inline_code>pattern="alphanumeric"</.inline_code>.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_alphanumeric(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 4: Custom Pattern (hex) --%>
      <.demo_section title="Custom Pattern (Hex)" code={showcase_source(:example_hex)}>
        <:description>
          8-character hex code with <.inline_code>pattern="[a-fA-F0-9]"</.inline_code>.
          Try typing "g" — rejected. Type "a" or "f" — accepted.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_hex(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 5: Multiple separators --%>
      <.demo_section title="With Separators" code={showcase_source(:example_separators)}>
        <:description>
          3 groups of 2 with separators between each group.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_separators(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 6: Disabled --%>
      <.demo_section title="Disabled" code={showcase_source(:example_disabled)}>
        <:description>
          Pre-filled and disabled. Slots show the value but input is not focusable.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_disabled(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 7: Hybrid --%>
      <.demo_section title="Hybrid" code={showcase_source(:example_hybrid)}>
        <:description>
          Client instant + server notification via <.inline_code>on_value_change</.inline_code> and
          <.inline_code>on_complete</.inline_code>.
        </:description>

        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_hybrid(assigns)}

            <div class="text-sm font-mono space-y-1">
              <div class="font-semibold text-muted-foreground">Event log:</div>
              <div :for={{event, val} <- @hybrid_events} class="text-muted-foreground">
                {event}: <span class="text-foreground">{val}</span>
              </div>
              <div :if={@hybrid_events == []} class="text-muted-foreground">(none)</div>
            </div>
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 8: Server-controlled --%>
      <.demo_section title="Server-controlled" code={showcase_source(:example_server)}>
        <:description>
          Server owns the value via the <.inline_code>value</.inline_code> assign.
          Buttons set the value from the server. Typing notifies but doesn't update locally.
        </:description>

        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_server(assigns)}

            <.state_display label="Server state" value={"value=#{@server_value}"} />
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 9: Form Integration --%>
      <.demo_section title="Form Integration" code={showcase_source(:example_form)}>
        <:description>
          Inside a <.inline_code>&lt;.form&gt;</.inline_code> using
          <.inline_code>form_field</.inline_code> with <.inline_code>type="input_otp"</.inline_code>.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_form(assigns)}
          </.card_content>
        </.card>
      </.demo_section>
    </div>
    """
  end
end
