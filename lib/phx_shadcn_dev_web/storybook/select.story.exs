defmodule Storybook.Select do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Select.select/1

  def imports do
    [
      {PhxShadcn.Components.Select,
       select_trigger: 1,
       select_value: 1,
       select_content: 1,
       select_item: 1,
       select_group: 1,
       select_label: 1,
       select_separator: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic select",
        attributes: %{id: "sb-select-default"},
        slots: [
          """
          <.select_trigger>
            <.select_value placeholder="Pick a fruit" />
          </.select_trigger>
          <.select_content>
            <.select_item value="apple">Apple</.select_item>
            <.select_item value="banana">Banana</.select_item>
            <.select_item value="cherry">Cherry</.select_item>
            <.select_item value="grape">Grape</.select_item>
            <.select_item value="pineapple">Pineapple</.select_item>
          </.select_content>
          """
        ]
      },
      %Variation{
        id: :with_groups,
        description: "Grouped options with labels and separators",
        attributes: %{id: "sb-select-groups"},
        slots: [
          """
          <.select_trigger class="w-[200px]">
            <.select_value placeholder="Select a food" />
          </.select_trigger>
          <.select_content>
            <.select_group>
              <.select_label>Fruits</.select_label>
              <.select_item value="apple">Apple</.select_item>
              <.select_item value="banana">Banana</.select_item>
            </.select_group>
            <.select_separator />
            <.select_group>
              <.select_label>Vegetables</.select_label>
              <.select_item value="carrot">Carrot</.select_item>
              <.select_item value="broccoli">Broccoli</.select_item>
            </.select_group>
          </.select_content>
          """
        ]
      },
      %Variation{
        id: :scrollable,
        description: "Long list showing overflow scroll",
        attributes: %{id: "sb-select-scroll"},
        slots: [
          """
          <.select_trigger class="w-[240px]">
            <.select_value placeholder="Select timezone" />
          </.select_trigger>
          <.select_content>
            <.select_item value="est">Eastern (EST)</.select_item>
            <.select_item value="cst">Central (CST)</.select_item>
            <.select_item value="mst">Mountain (MST)</.select_item>
            <.select_item value="pst">Pacific (PST)</.select_item>
            <.select_item value="gmt">Greenwich (GMT)</.select_item>
            <.select_item value="cet">Central Europe (CET)</.select_item>
            <.select_item value="eet">Eastern Europe (EET)</.select_item>
            <.select_item value="ist">India (IST)</.select_item>
            <.select_item value="jst">Japan (JST)</.select_item>
            <.select_item value="aest">Australia East (AEST)</.select_item>
            <.select_item value="nzst">New Zealand (NZST)</.select_item>
          </.select_content>
          """
        ]
      },
      %Variation{
        id: :disabled,
        description: "Mix of enabled and disabled items",
        attributes: %{id: "sb-select-disabled"},
        slots: [
          """
          <.select_trigger class="w-[200px]">
            <.select_value placeholder="Select a fruit" />
          </.select_trigger>
          <.select_content>
            <.select_item value="apple">Apple</.select_item>
            <.select_item value="banana" disabled>Banana (sold out)</.select_item>
            <.select_item value="cherry">Cherry</.select_item>
            <.select_item value="grape" disabled>Grape (sold out)</.select_item>
          </.select_content>
          """
        ]
      },
      %Variation{
        id: :small,
        description: "Small trigger size",
        attributes: %{id: "sb-select-small"},
        slots: [
          """
          <.select_trigger size="sm">
            <.select_value placeholder="Small" />
          </.select_trigger>
          <.select_content>
            <.select_item value="a">Option A</.select_item>
            <.select_item value="b">Option B</.select_item>
            <.select_item value="c">Option C</.select_item>
          </.select_content>
          """
        ]
      }
    ]
  end
end
