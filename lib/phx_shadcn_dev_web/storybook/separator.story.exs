defmodule Storybook.Separator do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Separator.separator/1

  def variations do
    [
      %Variation{
        id: :horizontal,
        description: "Horizontal separator (default)"
      },
      %Variation{
        id: :vertical,
        description: "Vertical separator",
        attributes: %{orientation: "vertical", class: ["h-8"]}
      },
      %Variation{
        id: :thick,
        description: "Thicker separator via class override",
        attributes: %{class: ["h-0.5"]}
      }
    ]
  end
end
