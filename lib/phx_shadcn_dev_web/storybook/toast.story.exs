defmodule Storybook.Toast do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Toast.toaster/1

  # PhoenixStorybook prefixes element IDs, so we can't use getElementById.
  # Instead, navigate the DOM relative to the button to find the toaster.
  @btn_class "inline-flex items-center justify-center rounded-md text-sm font-medium border border-input bg-background hover:bg-accent hover:text-accent-foreground h-9 px-4 py-2 cursor-pointer"

  defp toast_button(label, opts) do
    type = Keyword.get(opts, :type, "success")
    title = Keyword.get(opts, :title, label)
    desc = Keyword.get(opts, :description, "")

    detail =
      if desc == "" do
        "{type: '#{type}', title: '#{title}'}"
      else
        "{type: '#{type}', title: '#{title}', description: '#{desc}'}"
      end

    # Use string concatenation to avoid ~s interpreting "shadcn:" as a keyword
    "<button class=\"#{@btn_class}\" onclick=\"this.parentElement.querySelector('[aria-live]').dispatchEvent(new CustomEvent('phx-shadcn" <>
      ":toast', {detail: #{detail}}))\">#{label}</button>"
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default toaster (bottom-right)",
        attributes: %{
          id: "storybook-toaster",
          flash: %{}
        },
        template: """
        <div class="flex flex-wrap gap-2">
          #{toast_button("Success", type: "success", title: "Event created", description: "Sunday, December 03, 2023 at 9:00 AM")}
          #{toast_button("Error", type: "error", title: "Something went wrong", description: "Please try again later.")}
          #{toast_button("Info", type: "info", title: "New update available")}
          #{toast_button("Warning", type: "warning", title: "Disk space low", description: "Less than 10% remaining.")}
          <.psb-variation/>
        </div>
        """
      },
      %Variation{
        id: :top_center,
        description: "Top-center position",
        attributes: %{
          id: "storybook-toaster-top",
          flash: %{},
          position: "top-center"
        },
        template: """
        <div class="flex gap-2">
          #{toast_button("Show Top Toast", type: "info", title: "Info toast", description: "Displayed at the top center.")}
          <.psb-variation/>
        </div>
        """
      }
    ]
  end
end
