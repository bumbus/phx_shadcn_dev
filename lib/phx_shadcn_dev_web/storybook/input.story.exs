defmodule Storybook.Input do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Input.input/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default text input",
        attributes: %{placeholder: "Email"}
      },
      %Variation{
        id: :password,
        description: "Password input",
        attributes: %{type: "password", placeholder: "Password"}
      },
      %Variation{
        id: :file,
        description: "File input",
        attributes: %{type: "file"}
      },
      %Variation{
        id: :disabled,
        description: "Disabled input",
        attributes: %{placeholder: "Disabled", disabled: true}
      }
    ]
  end
end
