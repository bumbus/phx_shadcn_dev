defmodule Storybook.Textarea do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Textarea.textarea/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default textarea",
        attributes: %{placeholder: "Type your message here."}
      },
      %Variation{
        id: :with_value,
        description: "Textarea with value",
        attributes: %{placeholder: "Bio", value: "Hello world"}
      },
      %Variation{
        id: :disabled,
        description: "Disabled textarea",
        attributes: %{placeholder: "Disabled", disabled: true}
      }
    ]
  end
end
