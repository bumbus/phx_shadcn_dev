defmodule Storybook.Checkbox do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Checkbox.checkbox/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default unchecked",
        attributes: %{id: "cb-default", name: "terms"}
      },
      %Variation{
        id: :checked,
        description: "Checked",
        attributes: %{id: "cb-checked", name: "terms", checked: true}
      },
      %Variation{
        id: :disabled,
        description: "Disabled unchecked",
        attributes: %{id: "cb-disabled", name: "terms", disabled: true}
      },
      %Variation{
        id: :disabled_checked,
        description: "Disabled + checked",
        attributes: %{id: "cb-disabled-checked", name: "terms", checked: true, disabled: true}
      }
    ]
  end
end
