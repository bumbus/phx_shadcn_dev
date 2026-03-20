defmodule PhxShadcnDevWeb.Storybook do
  use PhoenixStorybook,
    otp_app: :phx_shadcn_dev,
    content_path: Path.expand("storybook", __DIR__),
    title: "PhxShadcn",
    css_path: "/assets/css/app.css",
    js_path: "/assets/js/app.js"
end
