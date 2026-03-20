defmodule Storybook.AspectRatio do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.AspectRatio.aspect_ratio/1

  def variations do
    [
      %Variation{
        id: :landscape,
        description: "16:9 ratio",
        attributes: %{ratio: 16 / 9, class: ["w-64"]},
        slots: [
          ~s|<img src="https://images.unsplash.com/photo-1588345921523-c2dcdb7f1dcd?w=800&dpr=2&q=80" class="size-full rounded-md object-cover" />|
        ]
      },
      %Variation{
        id: :square,
        description: "1:1 ratio",
        attributes: %{ratio: 1.0, class: ["w-32"]},
        slots: [
          ~s|<img src="https://images.unsplash.com/photo-1588345921523-c2dcdb7f1dcd?w=800&dpr=2&q=80" class="size-full rounded-md object-cover" />|
        ]
      }
    ]
  end
end
