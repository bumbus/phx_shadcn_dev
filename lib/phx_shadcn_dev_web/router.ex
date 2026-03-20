defmodule PhxShadcnDevWeb.Router do
  use PhxShadcnDevWeb, :router
  import PhoenixStorybook.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PhxShadcnDevWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhxShadcnDevWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/", PhxShadcnDevWeb do
    pipe_through :browser

    live_session :showcase,
      layout: {PhxShadcnDevWeb.Layouts, :showcase},
      on_mount: [PhxShadcnDevWeb.Hooks.ActiveNav] do
      live "/showcase", ShowcaseLive.Index
      live "/showcase/accordion", ShowcaseLive.Accordion
      live "/showcase/collapsible", ShowcaseLive.Collapsible
      live "/showcase/alert-dialog", ShowcaseLive.AlertDialog
      live "/showcase/dialog", ShowcaseLive.Dialog
      live "/showcase/sheet", ShowcaseLive.Sheet
      live "/showcase/popover", ShowcaseLive.Popover
      live "/showcase/tooltip", ShowcaseLive.Tooltip
      live "/showcase/hover-card", ShowcaseLive.HoverCard
      live "/showcase/context-menu", ShowcaseLive.ContextMenu
      live "/showcase/dropdown-menu", ShowcaseLive.DropdownMenu
      live "/showcase/menubar", ShowcaseLive.Menubar
      live "/showcase/radio-group", ShowcaseLive.RadioGroup
      live "/showcase/toggle", ShowcaseLive.Toggle
      live "/showcase/switch", ShowcaseLive.Switch
      live "/showcase/progress", ShowcaseLive.Progress
      live "/showcase/slider", ShowcaseLive.Slider
      live "/showcase/tabs", ShowcaseLive.Tabs
      live "/showcase/tabs/:tab", ShowcaseLive.Tabs
      live "/showcase/scroll-area", ShowcaseLive.ScrollArea
      live "/showcase/input-otp", ShowcaseLive.InputOTP
      live "/showcase/toast", ShowcaseLive.Toast
      live "/showcase/select", ShowcaseLive.Select
      live "/showcase/forms", ShowcaseLive.Form
      live "/showcase/js-events", ShowcaseLive.JsEvents
      live "/showcase/kitchen-sink", ShowcaseLive.KitchenSink
    end
  end

  scope "/" do
    storybook_assets()
  end

  scope "/" do
    pipe_through :browser

    live_storybook("/storybook", backend_module: PhxShadcnDevWeb.Storybook)
  end
end
