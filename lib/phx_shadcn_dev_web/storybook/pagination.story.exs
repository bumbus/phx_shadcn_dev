defmodule Storybook.Pagination do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Pagination.pagination/1

  def imports do
    [
      {PhxShadcn.Components.Pagination,
       pagination_content: 1,
       pagination_item: 1,
       pagination_link: 1,
       pagination_previous: 1,
       pagination_next: 1,
       pagination_ellipsis: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Pagination with active page",
        slots: [
          """
          <.pagination_content>
            <.pagination_item>
              <.pagination_previous href="#" />
            </.pagination_item>
            <.pagination_item>
              <.pagination_link href="#">1</.pagination_link>
            </.pagination_item>
            <.pagination_item>
              <.pagination_link href="#" is_active>2</.pagination_link>
            </.pagination_item>
            <.pagination_item>
              <.pagination_link href="#">3</.pagination_link>
            </.pagination_item>
            <.pagination_item>
              <.pagination_ellipsis />
            </.pagination_item>
            <.pagination_item>
              <.pagination_next href="#" />
            </.pagination_item>
          </.pagination_content>
          """
        ]
      }
    ]
  end
end
