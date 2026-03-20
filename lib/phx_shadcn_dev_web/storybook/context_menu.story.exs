defmodule Storybook.ContextMenu do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.ContextMenu.context_menu/1

  def imports do
    [
      {PhxShadcn.Components.ContextMenu,
       context_menu_trigger: 1,
       context_menu_content: 1,
       context_menu_item: 1,
       context_menu_checkbox_item: 1,
       context_menu_radio_group: 1,
       context_menu_radio_item: 1,
       context_menu_label: 1,
       context_menu_separator: 1,
       context_menu_shortcut: 1,
       context_menu_group: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic context menu",
        attributes: %{id: "cm-default"},
        slots: [
          """
          <.context_menu_trigger>
            <div class="flex h-[150px] w-[300px] items-center justify-center rounded-md border border-dashed text-sm">
              Right click here
            </div>
          </.context_menu_trigger>
          <.context_menu_content class="w-64">
            <.context_menu_item>
              Back
              <.context_menu_shortcut>⌘[</.context_menu_shortcut>
            </.context_menu_item>
            <.context_menu_item>
              Forward
              <.context_menu_shortcut>⌘]</.context_menu_shortcut>
            </.context_menu_item>
            <.context_menu_item>
              Reload
              <.context_menu_shortcut>⌘R</.context_menu_shortcut>
            </.context_menu_item>
            <.context_menu_separator />
            <.context_menu_item>
              View Page Source
              <.context_menu_shortcut>⌘U</.context_menu_shortcut>
            </.context_menu_item>
            <.context_menu_item>
              Inspect
              <.context_menu_shortcut>⌘⇧I</.context_menu_shortcut>
            </.context_menu_item>
          </.context_menu_content>
          """
        ]
      },
      %Variation{
        id: :destructive,
        description: "With a destructive item",
        attributes: %{id: "cm-destructive"},
        slots: [
          """
          <.context_menu_trigger>
            <div class="flex h-[150px] w-[300px] items-center justify-center rounded-md border border-dashed text-sm">
              Right click here
            </div>
          </.context_menu_trigger>
          <.context_menu_content class="w-64">
            <.context_menu_label>Account</.context_menu_label>
            <.context_menu_separator />
            <.context_menu_item>Profile</.context_menu_item>
            <.context_menu_item>Settings</.context_menu_item>
            <.context_menu_separator />
            <.context_menu_item variant="destructive">Delete Account</.context_menu_item>
          </.context_menu_content>
          """
        ]
      },
      %Variation{
        id: :disabled,
        description: "With disabled items",
        attributes: %{id: "cm-disabled"},
        slots: [
          """
          <.context_menu_trigger>
            <div class="flex h-[150px] w-[300px] items-center justify-center rounded-md border border-dashed text-sm">
              Right click here
            </div>
          </.context_menu_trigger>
          <.context_menu_content class="w-64">
            <.context_menu_item>Cut</.context_menu_item>
            <.context_menu_item>Copy</.context_menu_item>
            <.context_menu_item disabled>Paste</.context_menu_item>
            <.context_menu_separator />
            <.context_menu_item disabled>Delete</.context_menu_item>
            <.context_menu_item>Select All</.context_menu_item>
          </.context_menu_content>
          """
        ]
      }
    ]
  end
end
