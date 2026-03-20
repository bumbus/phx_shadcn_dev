defmodule Storybook.Progress do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Progress.progress/1

  def variations do
    [
      %Variation{
        id: :indeterminate,
        description: "Indeterminate (no value)",
        attributes: %{id: "progress-indeterminate"}
      },
      %Variation{
        id: :zero,
        description: "0%",
        attributes: %{id: "progress-zero", value: 0}
      },
      %Variation{
        id: :quarter,
        description: "25%",
        attributes: %{id: "progress-quarter", value: 25}
      },
      %Variation{
        id: :half,
        description: "50%",
        attributes: %{id: "progress-half", value: 50}
      },
      %Variation{
        id: :three_quarters,
        description: "75%",
        attributes: %{id: "progress-three-quarters", value: 75}
      },
      %Variation{
        id: :complete,
        description: "100% (complete)",
        attributes: %{id: "progress-complete", value: 100}
      }
    ]
  end
end
