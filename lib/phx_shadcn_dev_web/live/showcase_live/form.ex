defmodule PhxShadcnDevWeb.ShowcaseLive.Form do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  alias PhxShadcnDev.Schemas.Settings

  @impl true
  def mount(_params, _session, socket) do
    settings = %Settings{}
    form = settings |> Settings.changeset(%{}) |> to_form(as: "settings")

    {:ok,
     assign(socket,
       page_title: "Forms",
       settings: settings,
       form: form,
       current_state: settings,
       submitted_params: nil
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

    current_state = Ecto.Changeset.apply_changes(changeset)

    {:noreply, assign(socket, form: form, current_state: current_state)}
  end

  def handle_event("save", %{"settings" => params}, socket) do
    changeset = Settings.changeset(socket.assigns.settings, params)

    if changeset.valid? do
      {:noreply, assign(socket, submitted_params: params)}
    else
      form = changeset |> Map.put(:action, :validate) |> to_form(as: "settings")
      {:noreply, assign(socket, form: form)}
    end
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_text_inputs(assigns) do
    ~H"""
    <.form_field field={@form[:username]} label="Username"
      placeholder="shadcn" description="Your public display name (2–20 chars)." />

    <.form_field field={@form[:email]} label="Email" type="email"
      placeholder="you@example.com" description="We'll never share your email." />

    <.form_field field={@form[:bio]} label="Bio" type="textarea"
      placeholder="Tell us about yourself…" description="Max 160 characters." />

    <.form_field field={@form[:language]} label="Language (required)" type="native_select"
      prompt="Select a language"
      options={[{"English", "en"}, {"Deutsch", "de"}, {"Français", "fr"}, {"Español", "es"}, {"日本語", "ja"}]}
      description="No default — required field. Try submitting without selecting." />

    <.form_field field={@form[:framework]} label="Framework" type="select"
      prompt="Select a framework"
      options={[{"Next.js", "nextjs"}, {"SvelteKit", "sveltekit"}, {"Astro", "astro"}, {"Nuxt", "nuxt"}, {"Remix", "remix"}, {"Phoenix", "phoenix"}]}
      description="Custom Select component with floating dropdown." />
    """
  end

  defp example_interactive_components(assigns) do
    ~H"""
    <.form_field field={@form[:notifications]} label="Email Notifications" type="switch"
      default_checked={@form[:notifications].value == true}
      description="Receive email about new features and updates." />

    <.form_field field={@form[:bold]} label="Bold Text" type="toggle"
      default_pressed={@form[:bold].value == true} variant="outline"
      description="Enable bold formatting.">
      <svg xmlns="http://www.w3.org/2000/svg" class="size-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 12h9a4 4 0 0 1 0 8H7a1 1 0 0 1-1-1V5a1 1 0 0 1 1-1h7a4 4 0 0 1 0 8" /></svg>
    </.form_field>

    <.form_field field={@form[:terms]} label="Accept Terms" type="checkbox"
      description="You agree to our Terms of Service and Privacy Policy." />

    <.form_field field={@form[:alignment]} label="Text Alignment" type="toggle_group"
      variant="outline"
      description={"Current: #{@form[:alignment].value || "left"}"}>
      <.toggle_group_item value="left" variant="outline" aria-label="Align left">
        <svg xmlns="http://www.w3.org/2000/svg" class="size-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" x2="3" y1="6" y2="6" /><line x1="15" x2="3" y1="12" y2="12" /><line x1="17" x2="3" y1="18" y2="18" /></svg>
      </.toggle_group_item>
      <.toggle_group_item value="center" variant="outline" aria-label="Align center">
        <svg xmlns="http://www.w3.org/2000/svg" class="size-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" x2="3" y1="6" y2="6" /><line x1="17" x2="7" y1="12" y2="12" /><line x1="19" x2="5" y1="18" y2="18" /></svg>
      </.toggle_group_item>
      <.toggle_group_item value="right" variant="outline" aria-label="Align right">
        <svg xmlns="http://www.w3.org/2000/svg" class="size-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" x2="3" y1="6" y2="6" /><line x1="21" x2="9" y1="12" y2="12" /><line x1="21" x2="7" y1="18" y2="18" /></svg>
      </.toggle_group_item>
    </.form_field>

    <.form_field field={@form[:font_size]} label="Font Size (required)" type="toggle_group"
      variant="outline"
      description="No default — required field. Try submitting without selecting.">
      <.toggle_group_item value="sm" variant="outline" aria-label="Small">
        <span class="text-xs font-medium">S</span>
      </.toggle_group_item>
      <.toggle_group_item value="md" variant="outline" aria-label="Medium">
        <span class="text-sm font-medium">M</span>
      </.toggle_group_item>
      <.toggle_group_item value="lg" variant="outline" aria-label="Large">
        <span class="text-base font-medium">L</span>
      </.toggle_group_item>
    </.form_field>

    <.form_field field={@form[:volume]} label="Volume" type="slider"
      default_value={@form[:volume].value || 50}
      description={"Single-thumb slider. Current: #{@form[:volume].value || 50}"} />

    <.form_field field={@form[:price_range]} label="Price Range" type="slider"
      default_value={@form[:price_range].value || [20, 80]}
      step={5}
      description={"Range slider with two thumbs. Current: #{inspect(@form[:price_range].value || [20, 80], charlists: :as_lists)}"} />

    <.form_field field={@form[:theme]} label="Theme (required)" type="radio_group"
      description="No default — required field. Starts nil to test validation.">
      <div class="flex items-center space-x-2">
        <.radio_group_item value="light" id="theme-1" />
        <.label for="theme-1">Light</.label>
      </div>
      <div class="flex items-center space-x-2">
        <.radio_group_item value="dark" id="theme-2" />
        <.label for="theme-2">Dark</.label>
      </div>
      <div class="flex items-center space-x-2">
        <.radio_group_item value="system" id="theme-3" />
        <.label for="theme-3">System</.label>
      </div>
    </.form_field>

    <.form_field field={@form[:otp]} label="Verification Code (required)" type="input_otp"
      max_length={6}
      description="Enter exactly 6 digits — try 123456. Partial input shows a validation error." />
    """
  end

  defp example_nested_form(assigns) do
    ~H"""
    <.inputs_for :let={fp} field={@form[:profile]}>
      <.form_field field={fp[:display_name]} label="Display Name"
        placeholder="Your display name" description="Shown publicly on your profile." />

      <.form_field field={fp[:public]} label="Public Profile" type="switch"
        default_checked={fp[:public].value == true}
        description="Make your profile visible to others." />

      <.form_field field={fp[:contact_method]} label="Preferred Contact (required)" type="radio_group"
        description="Nested field via inputs_for — required, starts nil.">
        <div class="flex items-center space-x-2">
          <.radio_group_item value="email" id="contact-1" />
          <.label for="contact-1">Email</.label>
        </div>
        <div class="flex items-center space-x-2">
          <.radio_group_item value="phone" id="contact-2" />
          <.label for="contact-2">Phone</.label>
        </div>
        <div class="flex items-center space-x-2">
          <.radio_group_item value="none" id="contact-3" />
          <.label for="contact-3">Don't contact me</.label>
        </div>
      </.form_field>
    </.inputs_for>
    """
  end

  # ── Render ──────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Forms">
        End-to-end form integration: Ecto changeset validation, <.inline_code>to_form</.inline_code>,
        form primitives, and interactive components with hidden inputs.
      </.showcase_header>

      <.separator />

      <.form for={@form} phx-change="validate" phx-submit="save" class="space-y-10">
        <%!-- Demo 1: Text Inputs with Validation --%>
        <.demo_section title="Text Inputs with Validation" code={showcase_source(:example_text_inputs)}>
          <:description>
            Using <.inline_code>form_field</.inline_code> — one component for label,
            input, description, and error messages. Errors appear after interaction.
          </:description>

          <.card>
            <.card_content class="pt-6 space-y-4">
              {example_text_inputs(assigns)}
            </.card_content>
          </.card>
        </.demo_section>

        <%!-- Demo 2: Interactive Components in Forms --%>
        <.demo_section title="Interactive Components in Forms" code={showcase_source(:example_interactive_components)}>
          <:description>
            Checkbox, Switch, Toggle, and ToggleGroup with hidden inputs — proving the full
            <.inline_code>phx-change</.inline_code> round-trip.
          </:description>

          <.card>
            <.card_content class="pt-6 space-y-6">
              {example_interactive_components(assigns)}
            </.card_content>
          </.card>
        </.demo_section>

        <%!-- Demo 3: Nested Form with inputs_for --%>
        <.demo_section title="Nested Form (inputs_for)" code={showcase_source(:example_nested_form)}>
          <:description>
            A nested <.inline_code>:profile</.inline_code> embed using
            <.inline_code>inputs_for</.inline_code> — proving our form primitives
            work at nested depth.
          </:description>

          <.card>
            <.card_content class="pt-6 space-y-4">
              {example_nested_form(assigns)}
            </.card_content>
          </.card>
        </.demo_section>

        <%!-- Submit + Submitted Params --%>
        <.demo_section title="Submit">
          <:description>
            Submit the form and see the raw params the server receives.
          </:description>

          <.button type="submit">Save Settings</.button>

          <.card :if={@submitted_params}>
            <.card_header>
              <.card_title>Submitted Params</.card_title>
            </.card_header>
            <.card_content>
              <dl class="grid grid-cols-[auto_1fr] gap-x-4 gap-y-1.5 text-sm">
                <.param_row :for={{key, val} <- flat_params(@submitted_params)} key={key} val={val} />
              </dl>
            </.card_content>
          </.card>
        </.demo_section>
      </.form>

      <%!-- Live State Preview --%>
      <.demo_section title="Live State">
        <:description>
          The <.inline_code>%Settings{}</.inline_code> struct after applying the
          changeset. Updates as you type.
        </:description>

        <pre class="rounded-lg border bg-muted/50 p-4 text-sm font-mono overflow-x-auto"><code>{pretty_struct(@current_state)}</code></pre>
      </.demo_section>
    </div>
    """
  end

  # ── Helpers ──────────────────────────────────────────────────────────

  defp param_row(assigns) do
    ~H"""
    <dt class="font-mono text-muted-foreground">{@key}</dt>
    <dd class="font-mono">{inspect(@val)}</dd>
    """
  end

  defp pretty_struct(struct) do
    inspect(struct, pretty: true, width: 60)
  end

  defp flat_params(params, prefix \\ nil) do
    Enum.flat_map(params, fn {key, val} ->
      full_key = if prefix, do: "#{prefix}.#{key}", else: key

      case val do
        %{} = map when not is_struct(map) -> flat_params(map, full_key)
        _ -> [{full_key, val}]
      end
    end)
  end
end
