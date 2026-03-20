defmodule Storybook.AlertDialog do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.AlertDialog.alert_dialog/1

  def imports do
    [
      {PhxShadcn.Components.AlertDialog,
       alert_dialog_header: 1,
       alert_dialog_footer: 1,
       alert_dialog_title: 1,
       alert_dialog_description: 1,
       alert_dialog_cancel: 1,
       alert_dialog_action: 1},
      {PhxShadcn.Components.Button, button: 1}
    ]
  end

  # Vanilla JS triggers — PhoenixStorybook prefixes component IDs, so we can't
  # use ID-based show_alert_dialog/hide_alert_dialog helpers. Instead:
  #   Open:  querySelector('dialog') relative to button parent
  #   Close: JS.dispatch("phx-shadcn:hide") without `to:` — bubbles up to <dialog>
  @open_btn_class "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground shadow-xs transition-colors hover:bg-primary/90"

  defp open_button(label \\ "Open Alert Dialog") do
    ~s[<button class="#{@open_btn_class}" onclick="this.parentElement.querySelector('dialog').dispatchEvent(new Event('phx-shadcn:show'))">#{label}</button>]
  end

  @dismiss {:eval, ~s|Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")|}

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic alert dialog with cancel and action",
        attributes: %{id: "alert-dialog-default", on_cancel: @dismiss},
        template: """
        <div class="flex items-center gap-4">
          #{open_button()}
          <.psb-variation/>
        </div>
        """,
        slots: [
          """
          <.alert_dialog_header>
            <.alert_dialog_title id="alert-dialog-default-title">Are you absolutely sure?</.alert_dialog_title>
            <.alert_dialog_description id="alert-dialog-default-description">
              This action cannot be undone. This will permanently delete your account
              and remove your data from our servers.
            </.alert_dialog_description>
          </.alert_dialog_header>
          <.alert_dialog_footer>
            <.alert_dialog_cancel on_cancel={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>
              <.button variant="outline">Cancel</.button>
            </.alert_dialog_cancel>
            <.alert_dialog_action>
              <.button phx-click={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>Continue</.button>
            </.alert_dialog_action>
          </.alert_dialog_footer>
          """
        ]
      },
      %Variation{
        id: :destructive,
        description: "Destructive action with red button",
        attributes: %{id: "alert-dialog-destructive", on_cancel: @dismiss},
        template: """
        <div class="flex items-center gap-4">
          #{open_button("Delete Account")}
          <.psb-variation/>
        </div>
        """,
        slots: [
          """
          <.alert_dialog_header>
            <.alert_dialog_title id="alert-dialog-destructive-title">Delete account?</.alert_dialog_title>
            <.alert_dialog_description id="alert-dialog-destructive-description">
              This will permanently delete your account and all associated data.
              This action cannot be reversed.
            </.alert_dialog_description>
          </.alert_dialog_header>
          <.alert_dialog_footer>
            <.alert_dialog_cancel on_cancel={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>
              <.button variant="outline">Cancel</.button>
            </.alert_dialog_cancel>
            <.alert_dialog_action>
              <.button variant="destructive" phx-click={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>
                Yes, delete account
              </.button>
            </.alert_dialog_action>
          </.alert_dialog_footer>
          """
        ]
      },
      %Variation{
        id: :custom_width,
        description: "Wider alert dialog via class override",
        attributes: %{id: "alert-dialog-wide", class: "sm:max-w-2xl", on_cancel: @dismiss},
        template: """
        <div class="flex items-center gap-4">
          #{open_button("Open Wide Alert")}
          <.psb-variation/>
        </div>
        """,
        slots: [
          """
          <.alert_dialog_header>
            <.alert_dialog_title id="alert-dialog-wide-title">Review changes</.alert_dialog_title>
            <.alert_dialog_description id="alert-dialog-wide-description">
              The following changes will be applied to your production environment.
              Please review carefully before proceeding.
            </.alert_dialog_description>
          </.alert_dialog_header>
          <p class="text-sm text-muted-foreground">
            This wider alert dialog gives more room for detailed content.
          </p>
          <.alert_dialog_footer>
            <.alert_dialog_cancel on_cancel={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>
              <.button variant="outline">Cancel</.button>
            </.alert_dialog_cancel>
            <.alert_dialog_action>
              <.button phx-click={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>Apply Changes</.button>
            </.alert_dialog_action>
          </.alert_dialog_footer>
          """
        ]
      }
    ]
  end
end
