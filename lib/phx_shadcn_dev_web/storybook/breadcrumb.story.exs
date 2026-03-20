defmodule Storybook.Breadcrumb do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Breadcrumb.breadcrumb/1

  def imports do
    [
      {PhxShadcn.Components.Breadcrumb,
       breadcrumb_list: 1,
       breadcrumb_item: 1,
       breadcrumb_link: 1,
       breadcrumb_page: 1,
       breadcrumb_separator: 1,
       breadcrumb_ellipsis: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Basic breadcrumb",
        slots: [
          """
          <.breadcrumb_list>
            <.breadcrumb_item>
              <.breadcrumb_link href="/">Home</.breadcrumb_link>
            </.breadcrumb_item>
            <.breadcrumb_separator />
            <.breadcrumb_item>
              <.breadcrumb_link href="/components">Components</.breadcrumb_link>
            </.breadcrumb_item>
            <.breadcrumb_separator />
            <.breadcrumb_item>
              <.breadcrumb_page>Breadcrumb</.breadcrumb_page>
            </.breadcrumb_item>
          </.breadcrumb_list>
          """
        ]
      },
      %Variation{
        id: :from_list,
        description: "Breadcrumb from iterated list",
        slots: [
          """
          <.breadcrumb_list>
            <%= for {{label, href}, idx} <- Enum.with_index([{"Home", "/"}, {"Products", "/products"}, {"Shoes", "/products/shoes"}, {"Sneakers", nil}]) do %>
              <.breadcrumb_separator :if={idx > 0} />
              <.breadcrumb_item>
                <%= if href do %>
                  <.breadcrumb_link href={href}><%= label %></.breadcrumb_link>
                <% else %>
                  <.breadcrumb_page><%= label %></.breadcrumb_page>
                <% end %>
              </.breadcrumb_item>
            <% end %>
          </.breadcrumb_list>
          """
        ]
      },
      %Variation{
        id: :with_ellipsis,
        description: "Breadcrumb with collapsed items",
        slots: [
          """
          <.breadcrumb_list>
            <.breadcrumb_item>
              <.breadcrumb_link href="/">Home</.breadcrumb_link>
            </.breadcrumb_item>
            <.breadcrumb_separator />
            <.breadcrumb_item>
              <.breadcrumb_ellipsis />
            </.breadcrumb_item>
            <.breadcrumb_separator />
            <.breadcrumb_item>
              <.breadcrumb_link href="/docs/components">Components</.breadcrumb_link>
            </.breadcrumb_item>
            <.breadcrumb_separator />
            <.breadcrumb_item>
              <.breadcrumb_page>Breadcrumb</.breadcrumb_page>
            </.breadcrumb_item>
          </.breadcrumb_list>
          """
        ]
      }
    ]
  end
end
