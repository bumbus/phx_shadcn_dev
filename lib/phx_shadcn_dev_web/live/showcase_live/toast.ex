defmodule PhxShadcnDevWeb.ShowcaseLive.Toast do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  alias PhxShadcn.Components.Toast, as: ToastHelper

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Toast",
       undo_count: 0
     )}
  end

  # ── Events ────────────────────────────────────────────────────────

  @impl true
  def handle_event("show-default", _params, socket) do
    {:noreply, ToastHelper.toast(socket, :info, "Event has been created")}
  end

  def handle_event("show-success", _params, socket) do
    {:noreply, ToastHelper.toast(socket, :success, "Success", description: "Operation completed.")}
  end

  def handle_event("show-info", _params, socket) do
    {:noreply, ToastHelper.toast(socket, :info, "Info", description: "Here is some information.")}
  end

  def handle_event("show-warning", _params, socket) do
    {:noreply, ToastHelper.toast(socket, :warning, "Warning", description: "Please be careful.")}
  end

  def handle_event("show-error", _params, socket) do
    {:noreply, ToastHelper.toast(socket, :error, "Error", description: "Something went wrong.")}
  end

  def handle_event("show-description", _params, socket) do
    {:noreply,
     ToastHelper.toast(socket, :success, "Event Created",
       description: "Sunday, December 03, 2023 at 9:00 AM"
     )}
  end

  def handle_event("show-action", _params, socket) do
    {:noreply,
     ToastHelper.toast(socket, :success, "Event Created",
       description: "Sunday, December 03, 2023 at 9:00 AM",
       action: %{label: "Undo", event: "undo-action"}
     )}
  end

  def handle_event("undo-action", _params, socket) do
    {:noreply, assign(socket, undo_count: socket.assigns.undo_count + 1)}
  end

  def handle_event("show-persistent", _params, socket) do
    {:noreply,
     ToastHelper.toast(socket, :info, "Persistent Toast",
       description: "This toast won't auto-dismiss. Close it manually.",
       duration: 0
     )}
  end

  def handle_event("flash-info", _params, socket) do
    {:noreply, put_flash(socket, :info, "This came from put_flash(:info)!")}
  end

  def handle_event("flash-error", _params, socket) do
    {:noreply, put_flash(socket, :error, "This came from put_flash(:error)!")}
  end

  def handle_event("show-rich", _params, socket) do
    {:noreply,
     ToastHelper.toast(socket, :success, "File Uploaded",
       description: "photo.jpg was uploaded to your gallery.",
       action: %{label: "View", event: "undo-action"},
       duration: 8000
     )}
  end

  # ── Examples (source extracted at compile time) ──────────────────

  defp example_default(assigns) do
    ~H"""
    <.button variant="outline" phx-click="show-default">
      Give me a toast
    </.button>
    """
  end

  defp example_types(assigns) do
    ~H"""
    <div class="flex flex-wrap gap-2">
      <.button variant="outline" phx-click="show-success">Success</.button>
      <.button variant="outline" phx-click="show-info">Info</.button>
      <.button variant="outline" phx-click="show-warning">Warning</.button>
      <.button variant="outline" phx-click="show-error">Error</.button>
    </div>
    """
  end

  defp example_with_description(assigns) do
    ~H"""
    <.button variant="outline" phx-click="show-description">
      With description
    </.button>
    """
  end

  defp example_with_action(assigns) do
    ~H"""
    <.button variant="outline" phx-click="show-action">
      With action button
    </.button>
    <div :if={@undo_count > 0} class="mt-2 text-sm text-muted-foreground">
      Undo clicked {@undo_count} time(s)
    </div>
    """
  end

  defp example_persistent(assigns) do
    ~H"""
    <.button variant="outline" phx-click="show-persistent">
      Persistent toast
    </.button>
    """
  end

  defp example_flash(assigns) do
    ~H"""
    <div class="flex flex-wrap gap-2">
      <.button variant="outline" phx-click="flash-info">put_flash(:info)</.button>
      <.button variant="outline" phx-click="flash-error">put_flash(:error)</.button>
    </div>
    """
  end

  defp example_rich(assigns) do
    ~H"""
    <.button variant="outline" phx-click="show-rich">
      Rich push_event
    </.button>
    """
  end

  # ── Render ────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Toast">
        An opinionated toast component. Auto-dismissing, stackable, swipeable.
        Consumes <.inline_code>@flash</.inline_code> automatically — existing
        <.inline_code>put_flash/3</.inline_code> calls render as toasts
        with zero code changes.
      </.showcase_header>

      <.separator />

      <%!-- Demo 1: Default --%>
      <.demo_section title="Default" code={showcase_source(:example_default)}>
        <:description>
          Click the button to trigger a basic toast.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_default(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 2: Types --%>
      <.demo_section title="Types" code={showcase_source(:example_types)}>
        <:description>
          Four toast types: <.inline_code>success</.inline_code>,
          <.inline_code>info</.inline_code>, <.inline_code>warning</.inline_code>,
          <.inline_code>error</.inline_code>. Each has a distinct icon and color.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_types(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 3: With description --%>
      <.demo_section title="With Description" code={showcase_source(:example_with_description)}>
        <:description>
          Toasts can include a secondary description below the title.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_with_description(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 4: With action --%>
      <.demo_section title="With Action Button" code={showcase_source(:example_with_action)}>
        <:description>
          Add an action button that pushes an event back to the server.
          The counter below shows it works.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_with_action(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 5: Persistent --%>
      <.demo_section title="Persistent" code={showcase_source(:example_persistent)}>
        <:description>
          Set <.inline_code>duration: 0</.inline_code> to make a toast that stays
          until manually dismissed.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_persistent(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 6: Flash integration --%>
      <.demo_section title="Flash Integration" code={showcase_source(:example_flash)}>
        <:description>
          <.inline_code>put_flash(:info, ...)</.inline_code> and
          <.inline_code>put_flash(:error, ...)</.inline_code> are automatically
          rendered as toasts. Zero code changes required.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_flash(assigns)}
          </.card_content>
        </.card>
      </.demo_section>

      <%!-- Demo 7: Rich push_event --%>
      <.demo_section title="Rich push_event" code={showcase_source(:example_rich)}>
        <:description>
          Use <.inline_code>toast/4</.inline_code> for full control: description,
          action button, and custom duration.
        </:description>

        <.card>
          <.card_content class="pt-6">
            {example_rich(assigns)}
          </.card_content>
        </.card>
      </.demo_section>
    </div>
    """
  end
end
