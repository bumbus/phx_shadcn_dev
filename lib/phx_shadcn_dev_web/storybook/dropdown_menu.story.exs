defmodule Storybook.DropdownMenu do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.DropdownMenu.dropdown_menu/1

  def imports do
    [
      {PhxShadcn.Components.DropdownMenu,
       dropdown_menu_trigger: 1,
       dropdown_menu_content: 1,
       dropdown_menu_item: 1,
       dropdown_menu_checkbox_item: 1,
       dropdown_menu_radio_group: 1,
       dropdown_menu_radio_item: 1,
       dropdown_menu_label: 1,
       dropdown_menu_separator: 1,
       dropdown_menu_shortcut: 1,
       dropdown_menu_group: 1},
      {PhxShadcn.Components.Button, button: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic dropdown menu",
        attributes: %{id: "dm-default"},
        slots: [
          """
          <.dropdown_menu_trigger>
            <.button variant="outline">Open Menu</.button>
          </.dropdown_menu_trigger>
          <.dropdown_menu_content>
            <.dropdown_menu_label>My Account</.dropdown_menu_label>
            <.dropdown_menu_separator />
            <.dropdown_menu_item>Profile</.dropdown_menu_item>
            <.dropdown_menu_item>Billing</.dropdown_menu_item>
            <.dropdown_menu_item>Settings</.dropdown_menu_item>
            <.dropdown_menu_separator />
            <.dropdown_menu_item>Log out</.dropdown_menu_item>
          </.dropdown_menu_content>
          """
        ]
      },
      %Variation{
        id: :with_shortcuts,
        description: "Items with keyboard shortcut hints",
        attributes: %{id: "dm-shortcuts"},
        slots: [
          """
          <.dropdown_menu_trigger>
            <.button variant="outline">Actions</.button>
          </.dropdown_menu_trigger>
          <.dropdown_menu_content class="w-56">
            <.dropdown_menu_label>Actions</.dropdown_menu_label>
            <.dropdown_menu_separator />
            <.dropdown_menu_item>
              New Tab
              <.dropdown_menu_shortcut>⌘T</.dropdown_menu_shortcut>
            </.dropdown_menu_item>
            <.dropdown_menu_item>
              New Window
              <.dropdown_menu_shortcut>⌘N</.dropdown_menu_shortcut>
            </.dropdown_menu_item>
            <.dropdown_menu_item disabled>
              New Private Window
              <.dropdown_menu_shortcut>⇧⌘N</.dropdown_menu_shortcut>
            </.dropdown_menu_item>
          </.dropdown_menu_content>
          """
        ]
      },
      %Variation{
        id: :destructive,
        description: "With a destructive item",
        attributes: %{id: "dm-destructive"},
        slots: [
          """
          <.dropdown_menu_trigger>
            <.button variant="outline">Manage</.button>
          </.dropdown_menu_trigger>
          <.dropdown_menu_content class="w-56">
            <.dropdown_menu_label>Account</.dropdown_menu_label>
            <.dropdown_menu_separator />
            <.dropdown_menu_item>Profile</.dropdown_menu_item>
            <.dropdown_menu_item>Settings</.dropdown_menu_item>
            <.dropdown_menu_separator />
            <.dropdown_menu_item variant="destructive">Delete Account</.dropdown_menu_item>
          </.dropdown_menu_content>
          """
        ]
      },
      %Variation{
        id: :inset_label,
        description: "Label with inset for alignment with indicator items",
        attributes: %{id: "dm-inset"},
        slots: [
          """
          <.dropdown_menu_trigger>
            <.button variant="outline">View</.button>
          </.dropdown_menu_trigger>
          <.dropdown_menu_content class="w-56">
            <.dropdown_menu_label inset>Appearance</.dropdown_menu_label>
            <.dropdown_menu_separator />
            <.dropdown_menu_item inset>Compact</.dropdown_menu_item>
            <.dropdown_menu_item inset>Normal</.dropdown_menu_item>
            <.dropdown_menu_item inset>Comfortable</.dropdown_menu_item>
          </.dropdown_menu_content>
          """
        ]
      }
    ]
  end
end
