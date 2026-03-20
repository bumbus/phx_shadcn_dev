defmodule Storybook.Popover do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Popover.popover/1

  def imports do
    [
      {PhxShadcn.Components.Popover,
       popover_trigger: 1,
       popover_content: 1,
       popover_header: 1,
       popover_title: 1,
       popover_description: 1,
       popover_close: 1},
      {PhxShadcn.Components.Button, button: 1},
      {PhxShadcn.Components.Input, input: 1},
      {PhxShadcn.Components.Label, label: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default popover with form fields",
        attributes: %{id: "pop-default"},
        slots: [
          """
          <.popover_trigger>
            <.button variant="outline">Open popover</.button>
          </.popover_trigger>
          <.popover_content>
            <.popover_header class="mb-4">
              <.popover_title>Dimensions</.popover_title>
              <.popover_description>Set the dimensions for the layer.</.popover_description>
            </.popover_header>
            <div class="grid gap-2">
              <div class="grid grid-cols-3 items-center gap-4">
                <.label>Width</.label>
                <.input name="width" value="100%" class="col-span-2 h-8" />
              </div>
              <div class="grid grid-cols-3 items-center gap-4">
                <.label>Height</.label>
                <.input name="height" value="25px" class="col-span-2 h-8" />
              </div>
            </div>
          </.popover_content>
          """
        ]
      },
      %Variation{
        id: :with_header,
        description: "Popover with header, title, and description",
        attributes: %{id: "pop-header"},
        slots: [
          """
          <.popover_trigger>
            <.button variant="outline">Info</.button>
          </.popover_trigger>
          <.popover_content>
            <.popover_header>
              <.popover_title>About this feature</.popover_title>
              <.popover_description>
                This popover shows contextual information.
              </.popover_description>
            </.popover_header>
            <p class="mt-2 text-sm text-muted-foreground">
              Additional details can go here.
            </p>
          </.popover_content>
          """
        ]
      },
      %Variation{
        id: :align_start,
        description: "Aligned to start",
        attributes: %{id: "pop-start"},
        slots: [
          """
          <.popover_trigger>
            <.button variant="outline">Align Start</.button>
          </.popover_trigger>
          <.popover_content align="start">
            <.popover_title>Start aligned</.popover_title>
            <p class="mt-2 text-sm text-muted-foreground">Content aligned to start edge.</p>
          </.popover_content>
          """
        ]
      },
      %Variation{
        id: :side_top,
        description: "Opens above the trigger",
        attributes: %{id: "pop-top"},
        slots: [
          """
          <.popover_trigger>
            <.button variant="outline">Side Top</.button>
          </.popover_trigger>
          <.popover_content side="top">
            <.popover_title>Top placement</.popover_title>
            <p class="mt-2 text-sm text-muted-foreground">This popover opens above.</p>
          </.popover_content>
          """
        ]
      },
      %Variation{
        id: :custom_width,
        description: "Custom wider popover",
        attributes: %{id: "pop-wide"},
        slots: [
          """
          <.popover_trigger>
            <.button variant="outline">Wide Popover</.button>
          </.popover_trigger>
          <.popover_content class="w-96">
            <.popover_title>Wider popover</.popover_title>
            <p class="mt-2 text-sm text-muted-foreground">
              This popover uses a wider width override (w-96).
            </p>
          </.popover_content>
          """
        ]
      }
    ]
  end
end
