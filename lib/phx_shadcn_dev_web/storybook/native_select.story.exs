defmodule Storybook.NativeSelect do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.NativeSelect.native_select/1

  def imports do
    [
      {PhxShadcn.Components.NativeSelect,
       native_select_option: 1, native_select_optgroup: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default native select (options attr)",
        attributes: %{
          prompt: "Select a fruit",
          options: [{"Apple", "apple"}, {"Banana", "banana"}, {"Cherry", "cherry"}]
        }
      },
      %Variation{
        id: :small,
        description: "Small size",
        attributes: %{
          size: "sm",
          prompt: "Select a fruit",
          options: [{"Apple", "apple"}, {"Banana", "banana"}]
        }
      },
      %Variation{
        id: :disabled,
        description: "Disabled native select",
        attributes: %{
          disabled: true,
          prompt: "Disabled",
          options: [{"Apple", "apple"}]
        }
      },
      %Variation{
        id: :with_groups,
        description: "With option groups (inner_block)",
        slots: [
          ~s|<.native_select_option value="">Pick something</.native_select_option>|,
          """
          <.native_select_optgroup label="Fruits">
            <.native_select_option value="apple">Apple</.native_select_option>
            <.native_select_option value="banana">Banana</.native_select_option>
          </.native_select_optgroup>
          """,
          """
          <.native_select_optgroup label="Vegetables">
            <.native_select_option value="carrot">Carrot</.native_select_option>
            <.native_select_option value="spinach">Spinach</.native_select_option>
          </.native_select_optgroup>
          """
        ]
      }
    ]
  end
end
