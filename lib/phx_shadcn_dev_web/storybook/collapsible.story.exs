defmodule Storybook.Collapsible do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Collapsible.collapsible/1

  def imports do
    [
      {PhxShadcn.Components.Collapsible,
       collapsible_trigger: 1,
       collapsible_content: 1},
      {PhxShadcn.Components.Button, button: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Client-only collapsible",
        attributes: %{id: "collapsible-default"},
        slots: [
          """
          <.collapsible_trigger>
            <.button variant="ghost" size="sm">Toggle</.button>
          </.collapsible_trigger>
          <.collapsible_content>
            <div class="rounded-md border px-4 py-3 text-sm">
              Hidden content revealed on click.
            </div>
          </.collapsible_content>
          """
        ]
      },
      %Variation{
        id: :default_open,
        description: "Starts open",
        attributes: %{id: "collapsible-open", default_open: true},
        slots: [
          """
          <.collapsible_trigger>
            <.button variant="ghost" size="sm">Toggle</.button>
          </.collapsible_trigger>
          <.collapsible_content>
            <div class="rounded-md border px-4 py-3 text-sm">
              This content is visible by default.
            </div>
          </.collapsible_content>
          """
        ]
      },
      %Variation{
        id: :styled,
        description: "With border and heading",
        attributes: %{id: "collapsible-styled", class: ["space-y-2"]},
        slots: [
          """
          <div class="flex items-center justify-between">
            <h4 class="text-sm font-semibold">@peduarte starred 3 repositories</h4>
            <.collapsible_trigger>
              <.button variant="ghost" size="sm">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m7 15 5 5 5-5"/><path d="m7 9 5-5 5 5"/></svg>
              </.button>
            </.collapsible_trigger>
          </div>
          <div class="rounded-md border px-4 py-3 font-mono text-sm">@radix-ui/primitives</div>
          <.collapsible_content class={["space-y-2"]}>
            <div class="rounded-md border px-4 py-3 font-mono text-sm">@radix-ui/colors</div>
            <div class="rounded-md border px-4 py-3 font-mono text-sm">@stitches/react</div>
          </.collapsible_content>
          """
        ]
      }
    ]
  end
end
