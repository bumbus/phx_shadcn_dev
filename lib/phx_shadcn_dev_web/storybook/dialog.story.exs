defmodule Storybook.Dialog do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Dialog.dialog/1

  def imports do
    [
      {PhxShadcn.Components.Dialog,
       dialog_header: 1,
       dialog_footer: 1,
       dialog_title: 1,
       dialog_description: 1,
       dialog_close: 1},
      {PhxShadcn.Components.Button, button: 1}
    ]
  end

  # Vanilla JS triggers — PhoenixStorybook prefixes component IDs, so we can't
  # use ID-based show_dialog/hide_dialog helpers. Instead:
  #   Open:  querySelector('dialog') relative to button parent
  #   Close: JS.dispatch("phx-shadcn:hide") without `to:` — bubbles up to <dialog>
  @open_btn_class "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground shadow-xs transition-colors hover:bg-primary/90"

  defp open_button(label \\ "Open Dialog") do
    ~s[<button class="#{@open_btn_class}" onclick="this.parentElement.querySelector('dialog').dispatchEvent(new Event('phx-shadcn:show'))">#{label}</button>]
  end

  # For on_cancel: JS.dispatch without `to:` — when called via the hook's
  # notifyServer, execJS targets the dialog element directly. When called via
  # phx-click on a child button, the event bubbles up to the dialog.
  @dismiss {:eval, ~s|Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")|}

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic dialog with header, description, and footer",
        attributes: %{id: "dialog-default", on_cancel: @dismiss},
        template: """
        <div class="flex items-center gap-4">
          #{open_button()}
          <.psb-variation/>
        </div>
        """,
        slots: [
          """
          <.dialog_header>
            <.dialog_title id="dialog-default-title">Are you absolutely sure?</.dialog_title>
            <.dialog_description id="dialog-default-description">
              This action cannot be undone. This will permanently delete your account
              and remove your data from our servers.
            </.dialog_description>
          </.dialog_header>
          <.dialog_footer>
            <.dialog_close on_cancel={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>
              <.button variant="outline">Cancel</.button>
            </.dialog_close>
            <.button phx-click={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>Continue</.button>
          </.dialog_footer>
          """
        ]
      },
      %Variation{
        id: :no_close_button,
        description: "Without the X close button",
        attributes: %{id: "dialog-no-close", show_close: false, on_cancel: @dismiss},
        template: """
        <div class="flex items-center gap-4">
          #{open_button("Terms & Conditions")}
          <.psb-variation/>
        </div>
        """,
        slots: [
          """
          <.dialog_header>
            <.dialog_title id="dialog-no-close-title">Terms of Service</.dialog_title>
            <.dialog_description id="dialog-no-close-description">
              Please read the following terms carefully.
            </.dialog_description>
          </.dialog_header>
          <p class="text-sm text-muted-foreground">
            By using this service, you agree to our terms and conditions.
          </p>
          <.dialog_footer>
            <.dialog_close on_cancel={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>
              <.button variant="outline">Decline</.button>
            </.dialog_close>
            <.button phx-click={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>Accept</.button>
          </.dialog_footer>
          """
        ]
      },
      %Variation{
        id: :custom_width,
        description: "Wider dialog via class override",
        attributes: %{id: "dialog-wide", class: "sm:max-w-2xl", on_cancel: @dismiss},
        template: """
        <div class="flex items-center gap-4">
          #{open_button("Open Wide Dialog")}
          <.psb-variation/>
        </div>
        """,
        slots: [
          """
          <.dialog_header>
            <.dialog_title id="dialog-wide-title">Wide dialog</.dialog_title>
            <.dialog_description id="dialog-wide-description">
              This dialog uses a wider max-width override (sm:max-w-2xl).
            </.dialog_description>
          </.dialog_header>
          <p class="text-sm text-muted-foreground">
            The content area is wider than the default sm:max-w-lg.
          </p>
          <.dialog_footer>
            <.dialog_close on_cancel={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>
              <.button>Close</.button>
            </.dialog_close>
          </.dialog_footer>
          """
        ]
      },
      %Variation{
        id: :scrollable,
        description: "Dialog with scrollable content",
        attributes: %{id: "dialog-scroll", class: "max-h-[85vh] overflow-y-auto", on_cancel: @dismiss},
        template: """
        <div class="flex items-center gap-4">
          #{open_button("View License")}
          <.psb-variation/>
        </div>
        """,
        slots: [
          """
          <.dialog_header>
            <.dialog_title id="dialog-scroll-title">MIT License</.dialog_title>
            <.dialog_description id="dialog-scroll-description">
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
          </div>
          <.dialog_footer>
            <.dialog_close on_cancel={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>
              <.button>Close</.button>
            </.dialog_close>
          </.dialog_footer>
          """
        ]
      }
    ]
  end
end
