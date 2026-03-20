defmodule Storybook.Alert do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Alert.alert/1

  def imports do
    [{PhxShadcn.Components.Alert, alert_title: 1, alert_description: 1}]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default alert",
        slots: [
          ~s|<.alert_title>Heads up!</.alert_title>|,
          ~s|<.alert_description>You can add components to your app using the CLI.</.alert_description>|
        ]
      },
      %Variation{
        id: :with_icon,
        description: "With icon",
        slots: [
          ~s|<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="m11.25 11.25.041-.02a.75.75 0 0 1 1.063.852l-.708 2.836a.75.75 0 0 0 1.063.853l.041-.021M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9-3.75h.008v.008H12V8.25Z" /></svg>|,
          ~s|<.alert_title>Heads up!</.alert_title>|,
          ~s|<.alert_description>You can add components to your app using the CLI.</.alert_description>|
        ]
      },
      %Variation{
        id: :custom_info,
        description: "Custom info style via class override",
        attributes: %{class: ["border-blue-500/50 text-blue-700 bg-blue-50 [&>svg]:text-blue-600"]},
        slots: [
          ~s|<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="m11.25 11.25.041-.02a.75.75 0 0 1 1.063.852l-.708 2.836a.75.75 0 0 0 1.063.853l.041-.021M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9-3.75h.008v.008H12V8.25Z" /></svg>|,
          ~s|<.alert_title>Info</.alert_title>|,
          ~s|<.alert_description>This is a custom styled alert using class overrides.</.alert_description>|
        ]
      },
      %Variation{
        id: :destructive,
        description: "Destructive variant",
        attributes: %{variant: "destructive"},
        slots: [
          ~s|<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126ZM12 15.75h.007v.008H12v-.008Z" /></svg>|,
          ~s|<.alert_title>Error</.alert_title>|,
          ~s|<.alert_description>Something went wrong. Please try again.</.alert_description>|
        ]
      }
    ]
  end
end
