defmodule Storybook.HoverCard do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.HoverCard.hover_card/1

  def imports do
    [
      {PhxShadcn.Components.HoverCard, hover_card_trigger: 1, hover_card_content: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default hover card (bottom)",
        attributes: %{id: "hc-default"},
        slots: [
          """
          <.hover_card_trigger>
            <a href="#" class="font-medium text-primary underline underline-offset-4" onclick="this.closest('[phx-hook]').dispatchEvent(new Event('phx-shadcn:show'))">
              @shadcn
            </a>
          </.hover_card_trigger>
          <.hover_card_content>
            <p class="text-sm">The creator of shadcn/ui.</p>
          </.hover_card_content>
          """
        ]
      },
      %Variation{
        id: :side_top,
        description: "Top placement",
        attributes: %{id: "hc-top"},
        slots: [
          """
          <.hover_card_trigger>
            <a href="#" class="font-medium text-primary underline underline-offset-4" onclick="this.closest('[phx-hook]').dispatchEvent(new Event('phx-shadcn:show'))">
              Top
            </a>
          </.hover_card_trigger>
          <.hover_card_content side="top">
            <p class="text-sm">Card on top.</p>
          </.hover_card_content>
          """
        ]
      },
      %Variation{
        id: :side_right,
        description: "Right placement",
        attributes: %{id: "hc-right"},
        slots: [
          """
          <.hover_card_trigger>
            <a href="#" class="font-medium text-primary underline underline-offset-4" onclick="this.closest('[phx-hook]').dispatchEvent(new Event('phx-shadcn:show'))">
              Right
            </a>
          </.hover_card_trigger>
          <.hover_card_content side="right">
            <p class="text-sm">Card on right.</p>
          </.hover_card_content>
          """
        ]
      },
      %Variation{
        id: :custom_class,
        description: "Custom class override",
        attributes: %{id: "hc-custom"},
        slots: [
          """
          <.hover_card_trigger>
            <a href="#" class="font-medium text-primary underline underline-offset-4" onclick="this.closest('[phx-hook]').dispatchEvent(new Event('phx-shadcn:show'))">
              Custom
            </a>
          </.hover_card_trigger>
          <.hover_card_content class="w-80">
            <p class="text-sm">This card has a wider width override.</p>
          </.hover_card_content>
          """
        ]
      }
    ]
  end
end
