defmodule Storybook.Menubar do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Menubar.menubar/1

  def imports do
    [
      {PhxShadcn.Components.Menubar,
       menubar_menu: 1,
       menubar_trigger: 1,
       menubar_content: 1,
       menubar_item: 1,
       menubar_checkbox_item: 1,
       menubar_radio_group: 1,
       menubar_radio_item: 1,
       menubar_label: 1,
       menubar_separator: 1,
       menubar_shortcut: 1,
       menubar_group: 1,
       menubar_sub: 1,
       menubar_sub_trigger: 1,
       menubar_sub_content: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic menubar with File and Edit",
        attributes: %{id: "mb-default"},
        slots: [
          """
          <.menubar_menu>
            <.menubar_trigger>File</.menubar_trigger>
            <.menubar_content>
              <.menubar_item>
                New Tab <.menubar_shortcut>⌘T</.menubar_shortcut>
              </.menubar_item>
              <.menubar_item>
                New Window <.menubar_shortcut>⌘N</.menubar_shortcut>
              </.menubar_item>
              <.menubar_separator />
              <.menubar_item>
                Print... <.menubar_shortcut>⌘P</.menubar_shortcut>
              </.menubar_item>
            </.menubar_content>
          </.menubar_menu>
          <.menubar_menu>
            <.menubar_trigger>Edit</.menubar_trigger>
            <.menubar_content>
              <.menubar_item>Undo <.menubar_shortcut>⌘Z</.menubar_shortcut></.menubar_item>
              <.menubar_item>Redo <.menubar_shortcut>⇧⌘Z</.menubar_shortcut></.menubar_item>
              <.menubar_separator />
              <.menubar_item>Cut</.menubar_item>
              <.menubar_item>Copy</.menubar_item>
              <.menubar_item>Paste</.menubar_item>
            </.menubar_content>
          </.menubar_menu>
          """
        ]
      },
      %Variation{
        id: :with_sub_menu,
        description: "With a nested sub-menu",
        attributes: %{id: "mb-sub"},
        slots: [
          """
          <.menubar_menu>
            <.menubar_trigger>File</.menubar_trigger>
            <.menubar_content>
              <.menubar_item>New Tab</.menubar_item>
              <.menubar_separator />
              <.menubar_sub>
                <.menubar_sub_trigger>Share</.menubar_sub_trigger>
                <.menubar_sub_content>
                  <.menubar_item>Email Link</.menubar_item>
                  <.menubar_item>Messages</.menubar_item>
                  <.menubar_item>Notes</.menubar_item>
                </.menubar_sub_content>
              </.menubar_sub>
              <.menubar_separator />
              <.menubar_item>Print...</.menubar_item>
            </.menubar_content>
          </.menubar_menu>
          <.menubar_menu>
            <.menubar_trigger>Edit</.menubar_trigger>
            <.menubar_content>
              <.menubar_item>Undo</.menubar_item>
              <.menubar_item>Redo</.menubar_item>
            </.menubar_content>
          </.menubar_menu>
          """
        ]
      },
      %Variation{
        id: :disabled_items,
        description: "With disabled items",
        attributes: %{id: "mb-disabled"},
        slots: [
          """
          <.menubar_menu>
            <.menubar_trigger>File</.menubar_trigger>
            <.menubar_content>
              <.menubar_item>New Tab</.menubar_item>
              <.menubar_item disabled>New Incognito Window</.menubar_item>
              <.menubar_separator />
              <.menubar_item>Print...</.menubar_item>
            </.menubar_content>
          </.menubar_menu>
          <.menubar_menu>
            <.menubar_trigger>Edit</.menubar_trigger>
            <.menubar_content>
              <.menubar_item>Undo</.menubar_item>
              <.menubar_item disabled>Redo</.menubar_item>
              <.menubar_separator />
              <.menubar_item>Cut</.menubar_item>
              <.menubar_item disabled>Paste</.menubar_item>
            </.menubar_content>
          </.menubar_menu>
          """
        ]
      }
    ]
  end
end
