defmodule Storybook.Tooltip do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Tooltip.tooltip/1

  def imports do
    [
      {PhxShadcn.Components.Tooltip, tooltip_trigger: 1, tooltip_content: 1},
      {PhxShadcn.Components.Button, button: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default tooltip (top)",
        attributes: %{id: "tt-default"},
        slots: [
          """
          <.tooltip_trigger>
            <.button variant="outline" onclick="this.closest('[phx-hook]').dispatchEvent(new Event('phx-shadcn:show'))">
              Hover me
            </.button>
          </.tooltip_trigger>
          <.tooltip_content>
            Add to library
          </.tooltip_content>
          """
        ]
      },
      %Variation{
        id: :side_bottom,
        description: "Bottom placement",
        attributes: %{id: "tt-bottom"},
        slots: [
          """
          <.tooltip_trigger>
            <.button variant="outline" onclick="this.closest('[phx-hook]').dispatchEvent(new Event('phx-shadcn:show'))">
              Bottom
            </.button>
          </.tooltip_trigger>
          <.tooltip_content side="bottom">
            Tooltip on bottom
          </.tooltip_content>
          """
        ]
      },
      %Variation{
        id: :side_left,
        description: "Left placement",
        attributes: %{id: "tt-left"},
        slots: [
          """
          <.tooltip_trigger>
            <.button variant="outline" onclick="this.closest('[phx-hook]').dispatchEvent(new Event('phx-shadcn:show'))">
              Left
            </.button>
          </.tooltip_trigger>
          <.tooltip_content side="left">
            Tooltip on left
          </.tooltip_content>
          """
        ]
      },
      %Variation{
        id: :side_right,
        description: "Right placement",
        attributes: %{id: "tt-right"},
        slots: [
          """
          <.tooltip_trigger>
            <.button variant="outline" onclick="this.closest('[phx-hook]').dispatchEvent(new Event('phx-shadcn:show'))">
              Right
            </.button>
          </.tooltip_trigger>
          <.tooltip_content side="right">
            Tooltip on right
          </.tooltip_content>
          """
        ]
      },
      %Variation{
        id: :custom_class,
        description: "Custom class override",
        attributes: %{id: "tt-custom"},
        slots: [
          """
          <.tooltip_trigger>
            <.button variant="outline" onclick="this.closest('[phx-hook]').dispatchEvent(new Event('phx-shadcn:show'))">
              Custom
            </.button>
          </.tooltip_trigger>
          <.tooltip_content class="bg-destructive text-destructive-foreground">
            Danger tooltip
          </.tooltip_content>
          """
        ]
      }
    ]
  end
end
