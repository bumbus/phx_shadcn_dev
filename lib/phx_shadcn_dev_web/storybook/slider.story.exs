defmodule Storybook.Slider do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Slider.slider/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default (33)",
        attributes: %{id: "slider-default", default_value: 33}
      },
      %Variation{
        id: :at_min,
        description: "At min (0)",
        attributes: %{id: "slider-min", default_value: 0}
      },
      %Variation{
        id: :half,
        description: "Half (50)",
        attributes: %{id: "slider-half", default_value: 50}
      },
      %Variation{
        id: :at_max,
        description: "At max (100)",
        attributes: %{id: "slider-max", default_value: 100}
      },
      %Variation{
        id: :step_10,
        description: "Step 10",
        attributes: %{id: "slider-step", default_value: 50, step: 10}
      },
      %Variation{
        id: :custom_range,
        description: "Custom range 0–200",
        attributes: %{id: "slider-range", default_value: 100, min: 0, max: 200}
      },
      %Variation{
        id: :range,
        description: "Range (two thumbs)",
        attributes: %{id: "slider-range-dual", default_value: [25, 50], step: 5}
      },
      %Variation{
        id: :multiple,
        description: "Multiple thumbs",
        attributes: %{id: "slider-multi", default_value: [10, 20, 70], step: 10}
      },
      %Variation{
        id: :disabled,
        description: "Disabled",
        attributes: %{id: "slider-disabled", default_value: 60, disabled: true}
      }
    ]
  end
end
