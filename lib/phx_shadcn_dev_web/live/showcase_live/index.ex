defmodule PhxShadcnDevWeb.ShowcaseLive.Index do
  use PhxShadcnDevWeb, :live_view

  @components [
    # T2 — interactive, have dedicated showcase pages
    %{
      name: "Accordion",
      showcase: "/showcase/accordion",
      storybook: "/storybook/accordion",
      tier: 2,
      description: "Vertically stacked set of interactive headings that reveal content."
    },
    %{
      name: "Collapsible",
      showcase: "/showcase/collapsible",
      storybook: "/storybook/collapsible",
      tier: 2,
      description: "An interactive component that expands/collapses a panel."
    },
    %{
      name: "Toggle",
      showcase: "/showcase/toggle",
      storybook: "/storybook/toggle",
      tier: 2,
      description: "A two-state button that can be toggled on or off."
    },
    %{
      name: "ToggleGroup",
      showcase: "/showcase/toggle",
      storybook: "/storybook/toggle_group",
      tier: 2,
      description: "A set of toggle buttons supporting single or multiple selection."
    },
    %{
      name: "RadioGroup",
      showcase: "/showcase/radio-group",
      storybook: "/storybook/radio-group",
      tier: 2,
      description: "A set of radio buttons with keyboard navigation and single selection."
    },
    %{
      name: "Switch",
      showcase: "/showcase/switch",
      storybook: "/storybook/switch",
      tier: 2,
      description: "A control that allows the user to toggle between checked and unchecked."
    },
    %{
      name: "Progress",
      showcase: "/showcase/progress",
      storybook: "/storybook/progress",
      tier: 2,
      description: "Displays an indicator showing the completion progress of a task."
    },
    %{
      name: "ScrollArea",
      showcase: "/showcase/scroll-area",
      storybook: "/storybook/scroll-area",
      tier: 2,
      description: "Augments native scroll with custom, styled scrollbar overlays."
    },
    %{
      name: "Slider",
      showcase: "/showcase/slider",
      storybook: "/storybook/slider",
      tier: 2,
      description: "A draggable range input for selecting a numeric value."
    },
    %{
      name: "Tabs",
      showcase: "/showcase/tabs",
      storybook: "/storybook/tabs",
      tier: 2,
      description: "A set of layered sections of content displayed one at a time."
    },
    # T3 — significant interactivity
    %{
      name: "AlertDialog",
      showcase: "/showcase/alert-dialog",
      storybook: "/storybook/alert_dialog",
      tier: 3,
      description: "A forced-choice modal that requires an explicit user action. No backdrop dismiss."
    },
    %{
      name: "Dialog",
      showcase: "/showcase/dialog",
      storybook: "/storybook/dialog",
      tier: 3,
      description: "A modal dialog that interrupts the user with important content and expects a response."
    },
    %{
      name: "Sheet",
      showcase: "/showcase/sheet",
      storybook: "/storybook/sheet",
      tier: 3,
      description: "A panel that slides in from an edge. Unifies Sheet + Drawer with native <dialog>."
    },
    %{
      name: "Popover",
      showcase: "/showcase/popover",
      storybook: "/storybook/popover",
      tier: 3,
      description: "A floating panel anchored to a trigger with Floating UI positioning."
    },
    %{
      name: "Tooltip",
      showcase: "/showcase/tooltip",
      storybook: "/storybook/tooltip",
      tier: 3,
      description: "A popup that displays information on hover or focus using Floating UI."
    },
    %{
      name: "HoverCard",
      showcase: "/showcase/hover-card",
      storybook: "/storybook/hover_card",
      tier: 3,
      description: "A card that appears on hover with rich content. Like Tooltip's trigger with Popover's visual style."
    },
    # T4 — complex
    %{
      name: "ContextMenu",
      showcase: "/showcase/context-menu",
      storybook: "/storybook/context_menu",
      tier: 4,
      description: "A right-click triggered floating menu with cursor-anchored positioning and full keyboard navigation."
    },
    %{
      name: "DropdownMenu",
      showcase: "/showcase/dropdown-menu",
      storybook: "/storybook/dropdown_menu",
      tier: 4,
      description: "A click-triggered floating menu with keyboard navigation, typeahead, and checkbox/radio items."
    },
    %{
      name: "Menubar",
      showcase: "/showcase/menubar",
      storybook: "/storybook/menubar",
      tier: 4,
      description: "A horizontal menu bar with multi-menu coordination, hover-to-switch, and cross-menu keyboard navigation."
    },
    # T1 — static, kitchen sink + storybook
    %{
      name: "Alert",
      anchor: "alert",
      storybook: "/storybook/alert",
      tier: 1,
      description: "Displays a callout for important messages."
    },
    %{
      name: "AspectRatio",
      anchor: "aspect-ratio",
      storybook: "/storybook/aspect_ratio",
      tier: 1,
      description: "Displays content within a desired ratio."
    },
    %{
      name: "Avatar",
      anchor: "avatar",
      storybook: "/storybook/avatar",
      tier: 1,
      description: "An image element with a fallback for representing the user."
    },
    %{
      name: "Badge",
      anchor: "badge",
      storybook: "/storybook/badge",
      tier: 1,
      description: "Displays a badge or a component that looks like a badge."
    },
    %{
      name: "Breadcrumb",
      anchor: "breadcrumb",
      storybook: "/storybook/breadcrumb",
      tier: 1,
      description: "Displays a breadcrumb navigation trail."
    },
    %{
      name: "Checkbox",
      anchor: "checkbox",
      storybook: "/storybook/checkbox",
      tier: 1,
      description: "A native checkbox with CSS-only styling. No JS hook needed."
    },
    %{
      name: "Button",
      anchor: "button",
      storybook: "/storybook/button",
      tier: 1,
      description: "Displays a button or a component that looks like a button."
    },
    %{
      name: "Card",
      anchor: "card",
      storybook: "/storybook/card",
      tier: 1,
      description: "Displays a card with header, content, and footer."
    },
    %{
      name: "Input",
      anchor: "input",
      storybook: "/storybook/input",
      tier: 1,
      description: "Displays a form input field."
    },
    %{
      name: "Label",
      anchor: "label",
      storybook: "/storybook/label",
      tier: 1,
      description: "Renders an accessible label associated with controls."
    },
    %{
      name: "Pagination",
      anchor: "pagination",
      storybook: "/storybook/pagination",
      tier: 1,
      description: "Navigation for paged content."
    },
    %{
      name: "Separator",
      anchor: "separator",
      storybook: "/storybook/separator",
      tier: 1,
      description: "Visually or semantically separates content."
    },
    %{
      name: "Skeleton",
      anchor: "skeleton",
      storybook: "/storybook/skeleton",
      tier: 1,
      description: "Used to show a placeholder while content is loading."
    },
    %{
      name: "Table",
      anchor: "table",
      storybook: "/storybook/table",
      tier: 1,
      description: "A responsive table component."
    },
    %{
      name: "Textarea",
      anchor: "textarea",
      storybook: "/storybook/textarea",
      tier: 1,
      description: "Displays a multi-line text input."
    }
  ]

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Showcase", components: @components)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-6">
      <.showcase_header title="Components">
        Interactive showcase of PhxShadcn components. T2 components have dedicated pages with
        all 3 state modes. T1 components are collected on the
        <a href="/showcase/kitchen-sink" class="font-medium text-foreground underline underline-offset-4 hover:text-primary">
          Kitchen Sink
        </a>
        page.
      </.showcase_header>

      <.separator />

      <%!-- Special pages --%>
      <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        <a href="/showcase/forms" class="group flex flex-col">
          <.card class="flex h-full flex-col transition-colors group-hover:border-primary/50">
            <.card_header>
              <.card_title class="flex items-center justify-between">
                Forms
                <.badge variant="outline">Guide</.badge>
              </.card_title>
            </.card_header>
            <.card_content class="flex-1">
              <p class="text-sm text-muted-foreground">
                End-to-end form integration with Ecto changesets, validation, form primitives,
                and interactive components (Checkbox, Switch, Toggle, ToggleGroup, Slider) with hidden inputs.
              </p>
            </.card_content>
          </.card>
        </a>
        <a href="/showcase/js-events" class="group flex flex-col">
          <.card class="flex h-full flex-col transition-colors group-hover:border-primary/50">
            <.card_header>
              <.card_title class="flex items-center justify-between">
                JS Events
                <.badge variant="outline">Guide</.badge>
              </.card_title>
            </.card_header>
            <.card_content class="flex-1">
              <p class="text-sm text-muted-foreground">
                Explore the consistent JS event API shared by all interactive components.
                Control components from vanilla JS, wire them together, or command them from the server.
              </p>
            </.card_content>
          </.card>
        </a>
      </div>

      <%!-- Component cards --%>
      <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        <.component_card :for={comp <- @components} comp={comp} />
      </div>
    </div>
    """
  end

  defp component_card(assigns) do
    ~H"""
    <div class="group flex flex-col">
      <.card class="flex h-full flex-col transition-colors group-hover:border-primary/50">
        <.card_header>
          <.card_title class="flex items-center justify-between">
            {@comp.name}
            <.badge variant={if @comp.tier == 1, do: "secondary", else: "default"}>
              {"T#{@comp.tier}"}
            </.badge>
          </.card_title>
        </.card_header>
        <.card_content class="flex-1">
          <p class="text-sm text-muted-foreground">{@comp.description}</p>
        </.card_content>
        <.card_footer class="gap-2">
          <a :if={Map.has_key?(@comp, :showcase)} href={@comp.showcase}>
            <.button size="sm" variant="default">Showcase</.button>
          </a>
          <a :if={Map.has_key?(@comp, :anchor)} href={"/showcase/kitchen-sink##{@comp.anchor}"}>
            <.button size="sm" variant="default">Kitchen Sink</.button>
          </a>
          <a :if={Map.has_key?(@comp, :storybook)} href={@comp.storybook}>
            <.button size="sm" variant="outline">Storybook</.button>
          </a>
        </.card_footer>
      </.card>
    </div>
    """
  end
end
