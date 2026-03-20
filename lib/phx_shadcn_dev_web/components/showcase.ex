defmodule PhxShadcnDevWeb.Components.Showcase do
  @moduledoc """
  Barrel import for showcase helper components.

  `use PhxShadcnDevWeb.Components.Showcase` imports all showcase helpers
  (demo_section, event_log, inline_code, state_display) plus the shared
  `format_time/0` utility.
  """

  defmacro __using__(_opts) do
    quote do
      import PhxShadcnDevWeb.Components.Showcase.DemoSection
      import PhxShadcnDevWeb.Components.Showcase.EventLog
      import PhxShadcnDevWeb.Components.Showcase.InlineCode
      import PhxShadcnDevWeb.Components.Showcase.ShowcaseHeader
      import PhxShadcnDevWeb.Components.Showcase.StateDisplay
      import PhxShadcnDevWeb.Components.Showcase, only: [format_time: 0]
    end
  end

  @doc """
  Returns the current UTC time as a truncated string (HH:MM:SS).
  """
  def format_time do
    Time.utc_now() |> Time.truncate(:second) |> Time.to_string()
  end
end
