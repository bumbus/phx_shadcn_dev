defmodule Storybook.RadioGroup do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.RadioGroup.radio_group/1

  def imports do
    [
      {PhxShadcn.Components.RadioGroup, radio_group_item: 1},
      {PhxShadcn.Components.Label, label: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default vertical radio group",
        attributes: %{id: "rg-default", default_value: "comfortable"},
        slots: [
          """
          <div class="flex items-center space-x-2">
            <.radio_group_item value="default" id="rg-d-1" />
            <.label for="rg-d-1">Default</.label>
          </div>
          <div class="flex items-center space-x-2">
            <.radio_group_item value="comfortable" id="rg-d-2" />
            <.label for="rg-d-2">Comfortable</.label>
          </div>
          <div class="flex items-center space-x-2">
            <.radio_group_item value="compact" id="rg-d-3" />
            <.label for="rg-d-3">Compact</.label>
          </div>
          """
        ]
      },
      %Variation{
        id: :horizontal,
        description: "Horizontal orientation",
        attributes: %{id: "rg-horizontal", default_value: "md", orientation: "horizontal"},
        slots: [
          """
          <div class="flex items-center space-x-2">
            <.radio_group_item value="sm" id="rg-h-1" />
            <.label for="rg-h-1">Small</.label>
          </div>
          <div class="flex items-center space-x-2">
            <.radio_group_item value="md" id="rg-h-2" />
            <.label for="rg-h-2">Medium</.label>
          </div>
          <div class="flex items-center space-x-2">
            <.radio_group_item value="lg" id="rg-h-3" />
            <.label for="rg-h-3">Large</.label>
          </div>
          """
        ]
      },
      %Variation{
        id: :disabled,
        description: "With disabled items",
        attributes: %{id: "rg-disabled", default_value: "option-1"},
        slots: [
          """
          <div class="flex items-center space-x-2">
            <.radio_group_item value="option-1" id="rg-dis-1" />
            <.label for="rg-dis-1">Option 1</.label>
          </div>
          <div class="flex items-center space-x-2">
            <.radio_group_item value="option-2" id="rg-dis-2" disabled />
            <.label for="rg-dis-2" class="opacity-50">Option 2 (disabled)</.label>
          </div>
          <div class="flex items-center space-x-2">
            <.radio_group_item value="option-3" id="rg-dis-3" />
            <.label for="rg-dis-3">Option 3</.label>
          </div>
          """
        ]
      }
    ]
  end
end
