defmodule Storybook.Button do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Button.button/1

  def imports, do: [{PhxShadcn.Components.Badge, badge: 1}]

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default button",
        slots: ["Click me"]
      },
      %Variation{
        id: :destructive,
        description: "Destructive variant",
        attributes: %{variant: "destructive"},
        slots: ["Delete"]
      },
      %Variation{
        id: :outline,
        description: "Outline variant",
        attributes: %{variant: "outline"},
        slots: ["Outline"]
      },
      %Variation{
        id: :secondary,
        description: "Secondary variant",
        attributes: %{variant: "secondary"},
        slots: ["Secondary"]
      },
      %Variation{
        id: :ghost,
        description: "Ghost variant",
        attributes: %{variant: "ghost"},
        slots: ["Ghost"]
      },
      %Variation{
        id: :link,
        description: "Link variant",
        attributes: %{variant: "link"},
        slots: ["Link"]
      },
      %VariationGroup{
        id: :sizes,
        description: "All sizes",
        variations: [
          %Variation{
            id: :xs,
            attributes: %{size: "xs"},
            slots: ["Extra Small"]
          },
          %Variation{
            id: :sm,
            attributes: %{size: "sm"},
            slots: ["Small"]
          },
          %Variation{
            id: :default_size,
            attributes: %{size: "default"},
            slots: ["Default"]
          },
          %Variation{
            id: :lg,
            attributes: %{size: "lg"},
            slots: ["Large"]
          }
        ]
      },
      %Variation{
        id: :icon,
        description: "Icon size",
        attributes: %{size: "icon", variant: "outline"},
        slots: ["X"]
      },
      %Variation{
        id: :disabled,
        description: "Disabled state",
        attributes: %{disabled: true},
        slots: ["Disabled"]
      },
      %Variation{
        id: :with_phx_click,
        description: "With phx-click (loading state built in)",
        attributes: %{type: "submit"},
        slots: ["Submit"]
      },
      %Variation{
        id: :with_badge,
        description: "Button with badge",
        attributes: %{variant: "outline"},
        slots: [~s|Inbox <.badge variant="secondary">99+</.badge>|]
      },
      %Variation{
        id: :as_link,
        description: "Button rendered as a link (navigate)",
        attributes: %{variant: "default", navigate: "/"},
        slots: ["Go Home"]
      }
    ]
  end
end
