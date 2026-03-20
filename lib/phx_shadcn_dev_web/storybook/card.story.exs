defmodule Storybook.Card do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Card.card/1

  def imports do
    [
      {PhxShadcn.Components.Card,
       card_header: 1,
       card_title: 1,
       card_description: 1,
       card_action: 1,
       card_content: 1,
       card_footer: 1},
      {PhxShadcn.Components.Button, button: 1},
      {PhxShadcn.Components.Badge, badge: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic card",
        slots: [
          """
          <.card_header>
            <.card_title>Card Title</.card_title>
            <.card_description>Card description goes here.</.card_description>
          </.card_header>
          <.card_content>
            <p>Card content with some text.</p>
          </.card_content>
          """
        ]
      },
      %Variation{
        id: :with_footer,
        description: "Card with footer",
        slots: [
          """
          <.card_header>
            <.card_title>Account</.card_title>
            <.card_description>Manage your account settings.</.card_description>
          </.card_header>
          <.card_content>
            <p>Your plan: <strong>Pro</strong></p>
          </.card_content>
          <.card_footer>
            <.button size="sm">Save changes</.button>
          </.card_footer>
          """
        ]
      },
      %Variation{
        id: :with_action,
        description: "Card with header action",
        slots: [
          """
          <.card_header>
            <.card_title>Notifications</.card_title>
            <.card_description>You have 3 unread messages.</.card_description>
            <.card_action>
              <.badge variant="secondary">3</.badge>
            </.card_action>
          </.card_header>
          <.card_content>
            <p>Check your inbox for details.</p>
          </.card_content>
          """
        ]
      }
    ]
  end
end
