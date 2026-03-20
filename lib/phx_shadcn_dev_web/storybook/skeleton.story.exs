defmodule Storybook.Skeleton do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Skeleton.skeleton/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Text line placeholder",
        attributes: %{class: ["h-4 w-48"]}
      },
      %Variation{
        id: :circle,
        description: "Avatar placeholder",
        attributes: %{class: ["h-12 w-12 rounded-full"]}
      },
      %Variation{
        id: :card,
        description: "Card-sized placeholder",
        attributes: %{class: ["h-32 w-64"]}
      }
    ]
  end
end
