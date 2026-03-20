defmodule Storybook.Accordion do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Accordion.accordion/1

  def imports do
    [
      {PhxShadcn.Components.Accordion,
       accordion_item: 1,
       accordion_trigger: 1,
       accordion_content: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Single mode, collapsible",
        attributes: %{id: "accordion-default", type: "single", collapsible: true},
        slots: [
          """
          <.accordion_item value="item-1">
            <.accordion_trigger>Is it accessible?</.accordion_trigger>
            <.accordion_content>Yes. It adheres to the WAI-ARIA design pattern.</.accordion_content>
          </.accordion_item>
          <.accordion_item value="item-2">
            <.accordion_trigger>Is it styled?</.accordion_trigger>
            <.accordion_content>Yes. It comes with default styles that match the other components' aesthetic.</.accordion_content>
          </.accordion_item>
          <.accordion_item value="item-3">
            <.accordion_trigger>Is it animated?</.accordion_trigger>
            <.accordion_content>Yes. It's animated by default, but you can disable it if you prefer.</.accordion_content>
          </.accordion_item>
          """
        ]
      },
      %Variation{
        id: :multiple,
        description: "Multiple mode — open several items at once",
        attributes: %{id: "accordion-multiple", type: "multiple"},
        slots: [
          """
          <.accordion_item value="item-1">
            <.accordion_trigger>First section</.accordion_trigger>
            <.accordion_content>Content for the first section.</.accordion_content>
          </.accordion_item>
          <.accordion_item value="item-2">
            <.accordion_trigger>Second section</.accordion_trigger>
            <.accordion_content>Content for the second section.</.accordion_content>
          </.accordion_item>
          <.accordion_item value="item-3">
            <.accordion_trigger>Third section</.accordion_trigger>
            <.accordion_content>Content for the third section.</.accordion_content>
          </.accordion_item>
          """
        ]
      },
      %Variation{
        id: :default_open,
        description: "With an item open by default",
        attributes: %{id: "accordion-open", type: "single", collapsible: true, default_value: "item-1"},
        slots: [
          """
          <.accordion_item value="item-1">
            <.accordion_trigger>Open by default</.accordion_trigger>
            <.accordion_content>This item starts open.</.accordion_content>
          </.accordion_item>
          <.accordion_item value="item-2">
            <.accordion_trigger>Another item</.accordion_trigger>
            <.accordion_content>Click to open this one.</.accordion_content>
          </.accordion_item>
          """
        ]
      },
      %Variation{
        id: :disabled_item,
        description: "One item is disabled",
        attributes: %{id: "accordion-disabled", type: "single", collapsible: true},
        slots: [
          """
          <.accordion_item value="item-1">
            <.accordion_trigger>Enabled item</.accordion_trigger>
            <.accordion_content>This item can be toggled.</.accordion_content>
          </.accordion_item>
          <.accordion_item value="item-2" disabled>
            <.accordion_trigger>Disabled item</.accordion_trigger>
            <.accordion_content>This item cannot be toggled.</.accordion_content>
          </.accordion_item>
          <.accordion_item value="item-3">
            <.accordion_trigger>Another enabled item</.accordion_trigger>
            <.accordion_content>This item can also be toggled.</.accordion_content>
          </.accordion_item>
          """
        ]
      },
      %Variation{
        id: :custom_icon,
        description: "Plus/minus icon — vertical line collapses on open",
        attributes: %{id: "accordion-custom-icon", type: "single", collapsible: true},
        slots: [
          """
          <.accordion_item value="item-1">
            <.accordion_trigger>
              With plus/minus icon
              <:icon>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="shrink-0 text-muted-foreground">
                  <path d="M5 12h14" />
                  <path d="M12 5v14" class="origin-center transition-transform group-data-[state=open]/trigger:scale-y-0" style="transition-duration: var(--accordion-duration, 200ms)" />
                </svg>
              </:icon>
            </.accordion_trigger>
            <.accordion_content>Content with a custom icon.</.accordion_content>
          </.accordion_item>
          <.accordion_item value="item-2">
            <.accordion_trigger>
              Another item
              <:icon>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="shrink-0 text-muted-foreground">
                  <path d="M5 12h14" />
                  <path d="M12 5v14" class="origin-center transition-transform group-data-[state=open]/trigger:scale-y-0" style="transition-duration: var(--accordion-duration, 200ms)" />
                </svg>
              </:icon>
            </.accordion_trigger>
            <.accordion_content>More content here.</.accordion_content>
          </.accordion_item>
          """
        ]
      },
      %Variation{
        id: :no_icon,
        description: "No icon via hide_icon",
        attributes: %{id: "accordion-no-icon", type: "single", collapsible: true},
        slots: [
          """
          <.accordion_item value="item-1">
            <.accordion_trigger hide_icon>No icon trigger</.accordion_trigger>
            <.accordion_content>Content without an icon on the trigger.</.accordion_content>
          </.accordion_item>
          <.accordion_item value="item-2">
            <.accordion_trigger hide_icon>Another no-icon trigger</.accordion_trigger>
            <.accordion_content>More content here.</.accordion_content>
          </.accordion_item>
          """
        ]
      }
    ]
  end
end
