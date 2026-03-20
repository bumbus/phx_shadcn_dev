defmodule PhxShadcnDevWeb.ShowcaseLive.Dialog do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  alias PhxShadcn.Components.Dialog, as: DialogHelpers

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Dialog",
       # Server-controlled demo
       show_server_dialog: false,
       server_result: nil,
       # Form demo
       show_form_dialog: false,
       profile_name: "",
       profile_username: ""
     )}
  end

  # ── Server-controlled events ────────────────────────────────────────

  @impl true
  def handle_event("open-server-dialog", _params, socket) do
    {:noreply, assign(socket, show_server_dialog: true)}
  end

  def handle_event("close-server-dialog", _params, socket) do
    {:noreply, assign(socket, show_server_dialog: false)}
  end

  def handle_event("confirm-server-dialog", _params, socket) do
    {:noreply, assign(socket, show_server_dialog: false, server_result: "Confirmed!")}
  end

  # ── Form dialog events ─────────────────────────────────────────────

  def handle_event("open-form-dialog", _params, socket) do
    {:noreply, assign(socket, show_form_dialog: true)}
  end

  def handle_event("close-form-dialog", _params, socket) do
    {:noreply, assign(socket, show_form_dialog: false)}
  end

  def handle_event("save-profile", %{"name" => name, "username" => username}, socket) do
    {:noreply,
     assign(socket,
       show_form_dialog: false,
       profile_name: name,
       profile_username: username
     )}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_basic(assigns) do
    ~H"""
    <.card>
      <.card_content class="pt-6">
        <.button phx-click={DialogHelpers.show_dialog("basic-dialog")}>
          Open Dialog
        </.button>
      </.card_content>
    </.card>

    <.dialog id="basic-dialog" on_cancel={DialogHelpers.hide_dialog("basic-dialog")}>
      <.dialog_header>
        <.dialog_title id="basic-dialog-title">Are you absolutely sure?</.dialog_title>
        <.dialog_description id="basic-dialog-description">
          This action cannot be undone. This will permanently delete your account
          and remove your data from our servers.
        </.dialog_description>
      </.dialog_header>
      <.dialog_footer>
        <.dialog_close on_cancel={DialogHelpers.hide_dialog("basic-dialog")}>
          <.button variant="outline">Cancel</.button>
        </.dialog_close>
        <.button phx-click={DialogHelpers.hide_dialog("basic-dialog")}>Continue</.button>
      </.dialog_footer>
    </.dialog>
    """
  end

  defp example_with_form(assigns) do
    ~H"""
    <.card>
      <.card_content class="pt-6 space-y-4">
        <.button phx-click="open-form-dialog">Edit Profile</.button>

        <div :if={@profile_name != ""} class="text-sm text-muted-foreground">
          Saved: {@profile_name} (@{@profile_username})
        </div>
      </.card_content>
    </.card>

    <.dialog :if={@show_form_dialog} id="form-dialog" show on_cancel={JS.push("close-form-dialog")}>
      <.dialog_header>
        <.dialog_title id="form-dialog-title">Edit profile</.dialog_title>
        <.dialog_description id="form-dialog-description">
          Make changes to your profile here. Click save when you're done.
        </.dialog_description>
      </.dialog_header>
      <form phx-submit="save-profile" class="grid gap-4 py-4">
        <div class="grid grid-cols-4 items-center gap-4">
          <.label class="text-right">Name</.label>
          <.input name="name" value={@profile_name} class="col-span-3" placeholder="Pedro Duarte" />
        </div>
        <div class="grid grid-cols-4 items-center gap-4">
          <.label class="text-right">Username</.label>
          <.input name="username" value={@profile_username} class="col-span-3" placeholder="@peduarte" />
        </div>
        <.dialog_footer>
          <.button type="submit">Save changes</.button>
        </.dialog_footer>
      </form>
    </.dialog>
    """
  end

  defp example_server_controlled(assigns) do
    ~H"""
    <.card>
      <.card_content class="pt-6 space-y-4">
        <.button phx-click="open-server-dialog">Open Confirmation</.button>

        <div :if={@server_result} class="text-sm text-muted-foreground">
          Result: {@server_result}
        </div>
      </.card_content>
    </.card>

    <.dialog :if={@show_server_dialog} id="server-dialog" show on_cancel={JS.push("close-server-dialog")}>
      <.dialog_header>
        <.dialog_title id="server-dialog-title">Confirm action</.dialog_title>
        <.dialog_description id="server-dialog-description">
          Are you sure you want to proceed? This action will be processed on the server.
        </.dialog_description>
      </.dialog_header>
      <.dialog_footer>
        <.dialog_close on_cancel={JS.push("close-server-dialog")}>
          <.button variant="outline">Cancel</.button>
        </.dialog_close>
        <.button phx-click="confirm-server-dialog">Confirm</.button>
      </.dialog_footer>
    </.dialog>
    """
  end

  defp example_custom_footer(assigns) do
    ~H"""
    <.card>
      <.card_content class="pt-6">
        <.button variant="outline" phx-click={DialogHelpers.show_dialog("custom-footer-dialog")}>
          Terms & Conditions
        </.button>
      </.card_content>
    </.card>

    <.dialog id="custom-footer-dialog" on_cancel={DialogHelpers.hide_dialog("custom-footer-dialog")}>
      <.dialog_header>
        <.dialog_title id="custom-footer-dialog-title">Terms of Service</.dialog_title>
        <.dialog_description id="custom-footer-dialog-description">
          Please read the following terms carefully.
        </.dialog_description>
      </.dialog_header>
      <div class="text-sm text-muted-foreground leading-relaxed">
        <p>By using this service, you agree to our terms and conditions.
          This includes respecting other users, not misusing the platform,
          and maintaining the security of your account.</p>
      </div>
      <.dialog_footer>
        <.dialog_close on_cancel={DialogHelpers.hide_dialog("custom-footer-dialog")}>
          <.button variant="outline">Decline</.button>
        </.dialog_close>
        <.button phx-click={DialogHelpers.hide_dialog("custom-footer-dialog")}>Accept</.button>
      </.dialog_footer>
    </.dialog>
    """
  end

  defp example_scrollable(assigns) do
    ~H"""
    <.card>
      <.card_content class="pt-6">
        <.button variant="secondary" phx-click={DialogHelpers.show_dialog("scroll-dialog")}>
          View License
        </.button>
      </.card_content>
    </.card>

    <.dialog id="scroll-dialog" class="max-h-[85vh] overflow-y-auto" on_cancel={DialogHelpers.hide_dialog("scroll-dialog")}>
      <.dialog_header>
        <.dialog_title id="scroll-dialog-title">MIT License</.dialog_title>
        <.dialog_description id="scroll-dialog-description">
          Full license text below.
        </.dialog_description>
      </.dialog_header>
      <div class="text-sm text-muted-foreground leading-relaxed space-y-4">
        <p>Copyright (c) 2024 PhxShadcn</p>
        <p>Permission is hereby granted, free of charge, to any person obtaining a copy
          of this software and associated documentation files (the "Software"), to deal
          in the Software without restriction, including without limitation the rights
          to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
          copies of the Software, and to permit persons to whom the Software is
          furnished to do so, subject to the following conditions:</p>
        <p>The above copyright notice and this permission notice shall be included in all
          copies or substantial portions of the Software.</p>
        <p>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
          IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
          FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
          AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
          LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
          OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
          SOFTWARE.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
          incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
          nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
        <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore
          eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt
          in culpa qui officia deserunt mollit anim id est laborum.</p>
        <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium
          doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore
          veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>
      </div>
      <.dialog_footer>
        <.dialog_close on_cancel={DialogHelpers.hide_dialog("scroll-dialog")}>
          <.button>Close</.button>
        </.dialog_close>
      </.dialog_footer>
    </.dialog>
    """
  end

  # ── Render ──────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Dialog" storybook="/storybook/dialog">
        A modal dialog that interrupts the user with important content and expects a response.
        Built with native <code>&lt;dialog&gt;</code> + <code>showModal()</code>.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Basic (client-only) --%>
      <.demo_section title="Basic (Client-only)" code={showcase_source(:example_basic)}>
        <:description>
          Opens and closes entirely in JavaScript. No server round-trip.
          Uses <.inline_code>show_dialog/1</.inline_code> and <.inline_code>hide_dialog/1</.inline_code> helpers.
        </:description>

        {example_basic(assigns)}
      </.demo_section>

      <%!-- Demo 2: With Form (server-controlled) --%>
      <.demo_section title="With Form" code={showcase_source(:example_with_form)}>
        <:description>
          Server-controlled dialog containing a form. Uses the <.inline_code>:if</.inline_code> +
          <.inline_code>show</.inline_code> pattern.
        </:description>

        {example_with_form(assigns)}
      </.demo_section>

      <%!-- Demo 3: Server-controlled --%>
      <.demo_section title="Server-controlled" code={showcase_source(:example_server_controlled)}>
        <:description>
          Server opens and closes the dialog. Demonstrates
          <.inline_code>on_cancel=&lbrace;JS.push(...)&rbrace;</.inline_code> for server notification on dismiss.
        </:description>

        {example_server_controlled(assigns)}

        <.state_display label="Server state" value={"show=#{inspect(@show_server_dialog)}, result=#{inspect(@server_result)}"} />
      </.demo_section>

      <%!-- Demo 4: Custom footer with dialog_close --%>
      <.demo_section title="Custom Footer" code={showcase_source(:example_custom_footer)}>
        <:description>
          Shows <.inline_code>dialog_close</.inline_code> wrapping a button in the footer,
          alongside other action buttons.
        </:description>

        {example_custom_footer(assigns)}
      </.demo_section>

      <%!-- Demo 5: Scrollable content --%>
      <.demo_section title="Scrollable Content" code={showcase_source(:example_scrollable)}>
        <:description>
          Dialog with long content that scrolls internally.
        </:description>

        {example_scrollable(assigns)}
      </.demo_section>
    </div>
    """
  end
end
