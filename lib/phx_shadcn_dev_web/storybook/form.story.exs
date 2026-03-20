defmodule Storybook.Form do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Form.form_item/1

  def imports do
    [
      {PhxShadcn.Components.Form,
       form_label: 1, form_description: 1, form_message: 1, form_control: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Full field composition: label + input + description + message",
        slots: [
          """
          <.form_label for="demo-email">Email</.form_label>
          <input id="demo-email" type="email" placeholder="you@example.com"
            class="border-input h-9 w-full rounded-md border bg-transparent px-3 py-1 text-sm" />
          <.form_description>We'll never share your email.</.form_description>
          """
        ]
      },
      %Variation{
        id: :with_error,
        description: "Label + message showing an error",
        slots: [
          """
          <.form_label error>Email</.form_label>
          <input type="email" placeholder="you@example.com"
            class="border-input h-9 w-full rounded-md border bg-transparent px-3 py-1 text-sm aria-invalid:border-destructive"
            aria-invalid="true" />
          <.form_message errors={["can't be blank"]} />
          """
        ]
      },
      %Variation{
        id: :multiple_errors,
        description: "Multiple validation errors",
        slots: [
          """
          <.form_label error>Password</.form_label>
          <input type="password" placeholder="Password"
            class="border-input h-9 w-full rounded-md border bg-transparent px-3 py-1 text-sm aria-invalid:border-destructive"
            aria-invalid="true" />
          <.form_message errors={["should be at least 8 character(s)", "must contain a number"]} />
          """
        ]
      },
      %Variation{
        id: :description_only,
        description: "Label + description, no input",
        slots: [
          """
          <.form_label>Username</.form_label>
          <.form_description>Your public display name (2–20 chars).</.form_description>
          """
        ]
      }
    ]
  end
end
