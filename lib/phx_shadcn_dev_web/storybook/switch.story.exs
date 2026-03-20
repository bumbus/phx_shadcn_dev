defmodule Storybook.Switch do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Switch.switch/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default switch",
        attributes: %{id: "switch-default"}
      },
      %Variation{
        id: :sm,
        description: "Small size",
        attributes: %{id: "switch-sm", size: "sm"}
      },
      %Variation{
        id: :checked,
        description: "Starts checked",
        attributes: %{id: "switch-checked", default_checked: true}
      },
      %Variation{
        id: :disabled,
        description: "Disabled switch",
        attributes: %{id: "switch-disabled", disabled: true}
      },
      %Variation{
        id: :disabled_checked,
        description: "Disabled and checked",
        attributes: %{id: "switch-disabled-checked", default_checked: true, disabled: true}
      }
    ]
  end
end
