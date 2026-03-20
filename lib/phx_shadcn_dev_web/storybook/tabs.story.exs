defmodule Storybook.Tabs do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Tabs.tabs/1

  def imports do
    [
      {PhxShadcn.Components.Tabs, tabs_list: 1, tabs_trigger: 1, tabs_content: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default tabs (Account / Password)",
        attributes: %{id: "tabs-default", default_value: "account"},
        slots: [
          """
          <.tabs_list>
            <.tabs_trigger value="account">Account</.tabs_trigger>
            <.tabs_trigger value="password">Password</.tabs_trigger>
          </.tabs_list>
          <.tabs_content value="account" class="p-4 text-sm">
            Make changes to your account here.
          </.tabs_content>
          <.tabs_content value="password" class="p-4 text-sm">
            Change your password here.
          </.tabs_content>
          """
        ]
      },
      %Variation{
        id: :line_variant,
        description: "Line variant with underline indicator",
        attributes: %{id: "tabs-line", default_value: "overview"},
        slots: [
          """
          <.tabs_list variant="line">
            <.tabs_trigger value="overview">Overview</.tabs_trigger>
            <.tabs_trigger value="analytics">Analytics</.tabs_trigger>
            <.tabs_trigger value="reports">Reports</.tabs_trigger>
          </.tabs_list>
          <.tabs_content value="overview" class="p-4 text-sm">
            Overview content.
          </.tabs_content>
          <.tabs_content value="analytics" class="p-4 text-sm">
            Analytics content.
          </.tabs_content>
          <.tabs_content value="reports" class="p-4 text-sm">
            Reports content.
          </.tabs_content>
          """
        ]
      },
      %Variation{
        id: :vertical,
        description: "Vertical orientation",
        attributes: %{id: "tabs-vertical", default_value: "general", orientation: "vertical"},
        slots: [
          """
          <.tabs_list>
            <.tabs_trigger value="general">General</.tabs_trigger>
            <.tabs_trigger value="security">Security</.tabs_trigger>
            <.tabs_trigger value="notifications">Notifications</.tabs_trigger>
          </.tabs_list>
          <.tabs_content value="general" class="p-4 text-sm">
            General settings.
          </.tabs_content>
          <.tabs_content value="security" class="p-4 text-sm">
            Security settings.
          </.tabs_content>
          <.tabs_content value="notifications" class="p-4 text-sm">
            Notification preferences.
          </.tabs_content>
          """
        ]
      },
      %Variation{
        id: :disabled_tab,
        description: "With a disabled tab",
        attributes: %{id: "tabs-disabled", default_value: "active"},
        slots: [
          """
          <.tabs_list>
            <.tabs_trigger value="active">Active</.tabs_trigger>
            <.tabs_trigger value="disabled" disabled>Disabled</.tabs_trigger>
            <.tabs_trigger value="other">Other</.tabs_trigger>
          </.tabs_list>
          <.tabs_content value="active" class="p-4 text-sm">
            This tab is active.
          </.tabs_content>
          <.tabs_content value="disabled" class="p-4 text-sm">
            This should not be reachable.
          </.tabs_content>
          <.tabs_content value="other" class="p-4 text-sm">
            Other tab content.
          </.tabs_content>
          """
        ]
      }
    ]
  end
end
