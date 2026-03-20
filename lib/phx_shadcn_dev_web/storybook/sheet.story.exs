defmodule Storybook.Sheet do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Sheet.sheet/1

  def imports do
    [
      {PhxShadcn.Components.Sheet,
       sheet_header: 1,
       sheet_footer: 1,
       sheet_title: 1,
       sheet_description: 1,
       sheet_close: 1},
      {PhxShadcn.Components.Button, button: 1},
      {PhxShadcn.Components.Input, input: 1},
      {PhxShadcn.Components.Label, label: 1}
    ]
  end

  @open_btn_class "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground shadow-xs transition-colors hover:bg-primary/90"

  defp open_button(label \\ "Open Sheet") do
    ~s[<button class="#{@open_btn_class}" onclick="this.parentElement.querySelector('dialog').dispatchEvent(new Event('phx-shadcn:show'))">#{label}</button>]
  end

  @dismiss {:eval, ~s|Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")|}

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default right-side sheet",
        attributes: %{id: "sheet-default", on_cancel: @dismiss},
        template: """
        <div class="flex items-center gap-4">
          #{open_button()}
          <.psb-variation/>
        </div>
        """,
        slots: [
          """
          <.sheet_header>
            <.sheet_title id="sheet-default-title">Edit profile</.sheet_title>
            <.sheet_description id="sheet-default-description">
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
            <.button phx-click={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>Save changes</.button>
          </.sheet_footer>
          """
        ]
      },
      %Variation{
        id: :left,
        description: "Left-side sheet",
        attributes: %{id: "sheet-left", side: :left, on_cancel: @dismiss},
        template: """
        <div class="flex items-center gap-4">
          #{open_button("Open Left")}
          <.psb-variation/>
        </div>
        """,
        slots: [
          """
          <.sheet_header>
            <.sheet_title id="sheet-left-title">Navigation</.sheet_title>
            <.sheet_description id="sheet-left-description">
              Browse the sidebar menu.
            </.sheet_description>
          </.sheet_header>
          <div class="p-4">
            <p class="text-sm text-muted-foreground">Menu items would go here.</p>
          </div>
          <.sheet_footer>
            <.sheet_close on_cancel={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>
              <.button variant="outline">Close</.button>
            </.sheet_close>
          </.sheet_footer>
          """
        ]
      },
      %Variation{
        id: :bottom_with_handle,
        description: "Bottom sheet with drag handle (drawer style)",
        attributes: %{id: "sheet-bottom", side: :bottom, handle: true, on_cancel: @dismiss},
        template: """
        <div class="flex items-center gap-4">
          #{open_button("Open Drawer")}
          <.psb-variation/>
        </div>
        """,
        slots: [
          """
          <.sheet_header>
            <.sheet_title id="sheet-bottom-title">Move Goal</.sheet_title>
            <.sheet_description id="sheet-bottom-description">
              Set your daily activity goal.
            </.sheet_description>
          </.sheet_header>
          <div class="p-4 pb-0">
            <div class="flex items-center justify-center">
              <div class="flex-1 text-center">
                <div class="text-7xl font-bold tracking-tighter">350</div>
                <div class="text-[0.70rem] uppercase text-muted-foreground">Calories/day</div>
              </div>
            </div>
          </div>
          <.sheet_footer>
            <.button phx-click={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>Submit</.button>
          </.sheet_footer>
          """
        ]
      },
      %Variation{
        id: :custom_width,
        description: "Wider sheet via class override",
        attributes: %{id: "sheet-wide", class: "sm:max-w-lg", on_cancel: @dismiss},
        template: """
        <div class="flex items-center gap-4">
          #{open_button("Open Wide Sheet")}
          <.psb-variation/>
        </div>
        """,
        slots: [
          """
          <.sheet_header>
            <.sheet_title id="sheet-wide-title">Wide sheet</.sheet_title>
            <.sheet_description id="sheet-wide-description">
              This sheet uses a wider max-width override (sm:max-w-lg).
            </.sheet_description>
          </.sheet_header>
          <div class="p-4">
            <p class="text-sm text-muted-foreground">
              The content area is wider than the default sm:max-w-sm.
            </p>
          </div>
          <.sheet_footer>
            <.sheet_close on_cancel={Phoenix.LiveView.JS.dispatch("phx-shadcn:hide")}>
              <.button>Close</.button>
            </.sheet_close>
          </.sheet_footer>
          """
        ]
      }
    ]
  end
end
