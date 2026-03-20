defmodule Storybook.Avatar do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Avatar.avatar/1

  def imports do
    [
      {PhxShadcn.Components.Avatar,
       avatar_image: 1,
       avatar_fallback: 1,
       avatar_badge: 1,
       avatar_group: 1,
       avatar_group_count: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :with_image,
        description: "Avatar with image",
        slots: [
          ~s|<.avatar_image src="https://github.com/shadcn.png" alt="shadcn" />|,
          ~s|<.avatar_fallback>CN</.avatar_fallback>|
        ]
      },
      %Variation{
        id: :fallback_only,
        description: "Fallback only (no image)",
        slots: [
          ~s|<.avatar_fallback>JD</.avatar_fallback>|
        ]
      },
      %Variation{
        id: :size_sm,
        description: "Small size",
        attributes: %{size: "sm"},
        slots: [
          ~s|<.avatar_fallback>S</.avatar_fallback>|
        ]
      },
      %Variation{
        id: :size_lg,
        description: "Large size",
        attributes: %{size: "lg"},
        slots: [
          ~s|<.avatar_fallback>LG</.avatar_fallback>|
        ]
      }
    ]
  end
end
