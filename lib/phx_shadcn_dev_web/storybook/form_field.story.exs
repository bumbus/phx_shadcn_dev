defmodule Storybook.FormField do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.FormField.form_field/1

  def template do
    """
    <form class="w-full max-w-sm">
      <.psb-variation/>
    </form>
    """
  end

  def variations do
    [
      %Variation{
        id: :text,
        description: "Default text input",
        attributes: %{
          label: "Username",
          placeholder: "shadcn",
          description: "Your public display name.",
          field:
            {:eval,
             ~s|Phoenix.Component.to_form(%{"username" => ""}, as: :demo)[:username]|}
        }
      },
      %Variation{
        id: :email,
        description: "Email input",
        attributes: %{
          label: "Email",
          type: "email",
          placeholder: "you@example.com",
          description: "We'll never share your email.",
          field:
            {:eval,
             ~s|Phoenix.Component.to_form(%{"email" => ""}, as: :demo)[:email]|}
        }
      },
      %Variation{
        id: :password,
        description: "Password input",
        attributes: %{
          label: "Password",
          type: "password",
          placeholder: "Enter password",
          field:
            {:eval,
             ~s|Phoenix.Component.to_form(%{"password" => ""}, as: :demo)[:password]|}
        }
      },
      %Variation{
        id: :textarea,
        description: "Textarea type",
        attributes: %{
          label: "Bio",
          type: "textarea",
          placeholder: "Tell us about yourself…",
          description: "Max 160 characters.",
          field:
            {:eval,
             ~s|Phoenix.Component.to_form(%{"bio" => ""}, as: :demo)[:bio]|}
        }
      },
      %Variation{
        id: :switch,
        description: "Switch type (horizontal layout)",
        attributes: %{
          label: "Email Notifications",
          type: "switch",
          description: "Receive email about new features.",
          field:
            {:eval,
             ~s|Phoenix.Component.to_form(%{"notifications" => ""}, as: :demo)[:notifications]|}
        }
      },
      %Variation{
        id: :toggle,
        description: "Toggle type (horizontal layout)",
        attributes: %{
          label: "Bold",
          type: "toggle",
          variant: "outline",
          field:
            {:eval,
             ~s|Phoenix.Component.to_form(%{"bold" => ""}, as: :demo)[:bold]|}
        },
        slots: [
          """
          <svg xmlns="http://www.w3.org/2000/svg" class="size-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 12h9a4 4 0 0 1 0 8H7a1 1 0 0 1-1-1V5a1 1 0 0 1 1-1h7a4 4 0 0 1 0 8" /></svg>
          """
        ]
      },
      %Variation{
        id: :checkbox,
        description: "Checkbox type (horizontal layout)",
        attributes: %{
          label: "Accept Terms",
          type: "checkbox",
          description: "You agree to our Terms of Service.",
          field:
            {:eval,
             ~s|Phoenix.Component.to_form(%{"terms" => ""}, as: :demo)[:terms]|}
        }
      },
      %Variation{
        id: :disabled,
        description: "Disabled input",
        attributes: %{
          label: "Username",
          placeholder: "shadcn",
          disabled: true,
          field:
            {:eval,
             ~s|Phoenix.Component.to_form(%{"username" => ""}, as: :demo)[:username]|}
        }
      },
      %Variation{
        id: :with_errors,
        description: "Field with validation errors",
        attributes: %{
          label: "Email",
          type: "email",
          placeholder: "you@example.com",
          description: "We'll never share your email.",
          field:
            {:eval,
             ~s|%Phoenix.HTML.FormField{form: %Phoenix.HTML.Form{source: %{action: :validate}, impl: Phoenix.HTML.FormData.Map, id: "demo", name: "demo", data: %{}, params: %{"email" => ""}, hidden: [], errors: [], options: []}, field: :email, id: "demo_email", name: "demo[email]", errors: [{"can't be blank", [validation: :required]}], value: ""}|}
        }
      }
    ]
  end
end
