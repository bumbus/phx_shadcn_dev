defmodule PhxShadcnDevWeb.ShowcaseLive.AlertDialog do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  alias PhxShadcn.Components.AlertDialog, as: AlertDialogHelpers

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "AlertDialog",
       # Server-controlled demo
       show_server_dialog: false,
       server_result: nil
     )}
  end

  # ── Server-controlled events ────────────────────────────────────────

  @impl true
  def handle_event("open-server-dialog", _params, socket) do
    {:noreply, assign(socket, show_server_dialog: true)}
  end

  def handle_event("cancel-server-dialog", _params, socket) do
    {:noreply, assign(socket, show_server_dialog: false, server_result: "Cancelled")}
  end

  def handle_event("confirm-server-dialog", _params, socket) do
    {:noreply, assign(socket, show_server_dialog: false, server_result: "Confirmed!")}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_basic(assigns) do
    ~H"""
    <.button phx-click={AlertDialogHelpers.show_alert_dialog("basic-alert")}>
      Show Alert Dialog
    </.button>

    <.alert_dialog id="basic-alert" on_cancel={AlertDialogHelpers.hide_alert_dialog("basic-alert")}>
      <.alert_dialog_header>
        <.alert_dialog_title id="basic-alert-title">Are you absolutely sure?</.alert_dialog_title>
        <.alert_dialog_description id="basic-alert-description">
          This action cannot be undone. This will permanently delete your account
          and remove your data from our servers.
        </.alert_dialog_description>
      </.alert_dialog_header>
      <.alert_dialog_footer>
        <.alert_dialog_cancel on_cancel={AlertDialogHelpers.hide_alert_dialog("basic-alert")}>
          <.button variant="outline">Cancel</.button>
        </.alert_dialog_cancel>
        <.alert_dialog_action>
          <.button phx-click={AlertDialogHelpers.hide_alert_dialog("basic-alert")}>Continue</.button>
        </.alert_dialog_action>
      </.alert_dialog_footer>
    </.alert_dialog>
    """
  end

  defp example_destructive(assigns) do
    ~H"""
    <.button variant="destructive" phx-click={AlertDialogHelpers.show_alert_dialog("destructive-alert")}>
      Delete Account
    </.button>

    <.alert_dialog id="destructive-alert" on_cancel={AlertDialogHelpers.hide_alert_dialog("destructive-alert")}>
      <.alert_dialog_header>
        <.alert_dialog_title id="destructive-alert-title">Delete account?</.alert_dialog_title>
        <.alert_dialog_description id="destructive-alert-description">
          This will permanently delete your account and all associated data.
          This action cannot be reversed.
        </.alert_dialog_description>
      </.alert_dialog_header>
      <.alert_dialog_footer>
        <.alert_dialog_cancel on_cancel={AlertDialogHelpers.hide_alert_dialog("destructive-alert")}>
          <.button variant="outline">Cancel</.button>
        </.alert_dialog_cancel>
        <.alert_dialog_action>
          <.button variant="destructive" phx-click={AlertDialogHelpers.hide_alert_dialog("destructive-alert")}>
            Yes, delete account
          </.button>
        </.alert_dialog_action>
      </.alert_dialog_footer>
    </.alert_dialog>
    """
  end

  defp example_server_controlled(assigns) do
    ~H"""
    <.button phx-click="open-server-dialog">Publish Changes</.button>

    <div :if={@server_result} class="text-sm text-muted-foreground">
      Result: {@server_result}
    </div>

    <.alert_dialog :if={@show_server_dialog} id="server-alert" show on_cancel={JS.push("cancel-server-dialog")}>
      <.alert_dialog_header>
        <.alert_dialog_title id="server-alert-title">Publish changes?</.alert_dialog_title>
        <.alert_dialog_description id="server-alert-description">
          This will make your changes visible to all users. Are you sure you want to continue?
        </.alert_dialog_description>
      </.alert_dialog_header>
      <.alert_dialog_footer>
        <.alert_dialog_cancel on_cancel={JS.push("cancel-server-dialog")}>
          <.button variant="outline">Cancel</.button>
        </.alert_dialog_cancel>
        <.alert_dialog_action>
          <.button phx-click="confirm-server-dialog">Yes, publish</.button>
        </.alert_dialog_action>
      </.alert_dialog_footer>
    </.alert_dialog>
    """
  end

  # ── Render ──────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="AlertDialog" storybook="/storybook/alert_dialog">
        A forced-choice modal dialog that requires an explicit user action.
        Unlike Dialog, backdrop clicks are ignored and the close button is hidden by default.
        Built with native <code>&lt;dialog&gt;</code> + <code>showModal()</code> and <code>role="alertdialog"</code>.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Basic (client-only) --%>
      <.demo_section title="Basic (Client-only)" code={showcase_source(:example_basic)}>
        <:description>
          Opens and closes entirely in JavaScript. Backdrop click does nothing.
          Only the Cancel or Continue buttons dismiss the dialog.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_basic(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Destructive action --%>
      <.demo_section title="Destructive" code={showcase_source(:example_destructive)}>
        <:description>
          Delete confirmation with a <.inline_code>variant="destructive"</.inline_code> action button.
          The destructive styling makes the consequences clear.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_destructive(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: Server-controlled --%>
      <.demo_section title="Server-controlled" code={showcase_source(:example_server_controlled)}>
        <:description>
          Server opens and closes the dialog. Demonstrates
          <.inline_code>on_cancel=&lbrace;JS.push(...)&rbrace;</.inline_code> for server notification on dismiss.
          The result displays which button was pressed.
        </:description>

        <.card>
          <.card_content class="pt-6 space-y-4">
            {example_server_controlled(assigns)}
          </.card_content>
        </.card>

        <.state_display label="Server state" value={"show=#{inspect(@show_server_dialog)}, result=#{inspect(@server_result)}"} />
      </.demo_section>
    </div>
    """
  end
end
