defmodule Storybook.Label do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Label.label/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default label",
        slots: ["Email"]
      },
      %Variation{
        id: :with_for,
        description: "Label with for attribute",
        attributes: %{for: "username"},
        slots: ["Username"]
      }
    ]
  end
end
