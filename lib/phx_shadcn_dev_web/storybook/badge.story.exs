defmodule Storybook.Badge do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Badge.badge/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default badge",
        slots: ["Badge"]
      },
      %Variation{
        id: :secondary,
        description: "Secondary variant",
        attributes: %{variant: "secondary"},
        slots: ["Secondary"]
      },
      %Variation{
        id: :destructive,
        description: "Destructive variant",
        attributes: %{variant: "destructive"},
        slots: ["Destructive"]
      },
      %Variation{
        id: :outline,
        description: "Outline variant",
        attributes: %{variant: "outline"},
        slots: ["Outline"]
      },
      %Variation{
        id: :ghost,
        description: "Ghost variant",
        attributes: %{variant: "ghost"},
        slots: ["Ghost"]
      },
      %Variation{
        id: :link,
        description: "Link variant",
        attributes: %{variant: "link"},
        slots: ["Link"]
      }
    ]
  end
end
