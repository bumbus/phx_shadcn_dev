defmodule PhxShadcnDevWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use PhxShadcnDevWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates("layouts/*")

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr(:flash, :map, required: true, doc: "the map of flash messages")

  attr(:current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"
  )

  attr(:inner_content, :any, default: nil)
  slot(:inner_block)

  def app(assigns) do
    ~H"""
    <.site_header current="home" />

    <main>
      {@inner_content}
    </main>

    <.site_footer />
    <.toaster flash={@flash} />
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr(:flash, :map, required: true, doc: "the map of flash messages")
  attr(:id, :string, default: "flash-group", doc: "the optional id of flash container")

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Provides dark/light theme toggle.

  Toggles the `dark` class on the root `<html>` element.
  """
  def theme_toggle(assigns) do
    ~H"""
    <button
      class="inline-flex items-center justify-center size-9 rounded-md border border-input bg-background hover:bg-accent hover:text-accent-foreground cursor-pointer"
      onclick="document.documentElement.classList.toggle('dark')"
    >
      <.icon name="hero-sun-micro" class="size-4 dark:hidden" />
      <.icon name="hero-moon-micro" class="size-4 hidden dark:block" />
    </button>
    """
  end

  # ── Logo ────────────────────────────────────────────────────────────

  @doc """
  Renders the PhxShadcn combined logo: Phoenix flame + shadcn slashes.
  """
  attr :class, :string, default: ""

  def logo(assigns) do
    ~H"""
    <span class={["inline-flex items-center gap-1.5", @class]}>
      <svg viewBox="0 0 71 48" class="h-7 text-[#FD4F00]" aria-hidden="true">
        <path
          d="m26.371 33.477-.552-.1c-3.92-.729-6.397-3.1-7.57-6.829-.733-2.324.597-4.035 3.035-4.148 1.995-.092 3.362 1.055 4.57 2.39 1.557 1.72 2.984 3.558 4.514 5.305 2.202 2.515 4.797 4.134 8.347 3.634 3.183-.448 5.958-1.725 8.371-3.828.363-.316.761-.592 1.144-.886l-.241-.284c-2.027.63-4.093.841-6.205.735-3.195-.16-6.24-.828-8.964-2.582-2.486-1.601-4.319-3.746-5.19-6.611-.704-2.315.736-3.934 3.135-3.6.948.133 1.746.56 2.463 1.165.583.493 1.143 1.015 1.738 1.493 2.8 2.25 6.712 2.375 10.265-.068-5.842-.026-9.817-3.24-13.308-7.313-1.366-1.594-2.7-3.216-4.095-4.785-2.698-3.036-5.692-5.71-9.79-6.623C12.8-.623 7.745.14 2.893 2.361 1.926 2.804.997 3.319 0 4.149c.494 0 .763.006 1.032 0 2.446-.064 4.28 1.023 5.602 3.024.962 1.457 1.415 3.104 1.761 4.798.513 2.515.247 5.078.544 7.605.761 6.494 4.08 11.026 10.26 13.346 2.267.852 4.591 1.135 7.172.555ZM10.751 3.852c-.976.246-1.756-.148-2.56-.962 1.377-.343 2.592-.476 3.897-.528-.107.848-.607 1.306-1.336 1.49Zm32.002 37.924c-.085-.626-.62-.901-1.04-1.228-1.857-1.446-4.03-1.958-6.333-2-1.375-.026-2.735-.128-4.031-.61-.595-.22-1.26-.505-1.244-1.272.015-.78.693-1 1.31-1.184.505-.15 1.026-.247 1.6-.382-1.46-.936-2.886-1.065-4.787-.3-2.993 1.202-5.943 1.06-8.926-.017-1.684-.608-3.179-1.563-4.735-2.408l-.043.03a2.96 2.96 0 0 0 .04-.029c-.038-.117-.107-.12-.197-.054l.122.107c1.29 2.115 3.034 3.817 5.004 5.271 3.793 2.8 7.936 4.471 12.784 3.73A66.714 66.714 0 0 1 37 40.877c1.98-.16 3.866.398 5.753.899Zm-9.14-30.345c-.105-.076-.206-.266-.42-.069 1.745 2.36 3.985 4.098 6.683 5.193 4.354 1.767 8.773 2.07 13.293.51 3.51-1.21 6.033-.028 7.343 3.38.19-3.955-2.137-6.837-5.843-7.401-2.084-.318-4.01.373-5.962.94-5.434 1.575-10.485.798-15.094-2.553Zm27.085 15.425c.708.059 1.416.123 2.124.185-1.6-1.405-3.55-1.517-5.523-1.404-3.003.17-5.167 1.903-7.14 3.972-1.739 1.824-3.31 3.87-5.903 4.604.043.078.054.117.066.117.35.005.699.021 1.047.005 3.768-.17 7.317-.965 10.14-3.7.89-.86 1.685-1.817 2.544-2.71.716-.746 1.584-1.159 2.645-1.07Zm-8.753-4.67c-2.812.246-5.254 1.409-7.548 2.943-1.766 1.18-3.654 1.738-5.776 1.37-.374-.066-.75-.114-1.124-.17l-.013.156c.135.07.265.151.405.207.354.14.702.308 1.07.395 4.083.971 7.992.474 11.516-1.803 2.221-1.435 4.521-1.707 7.013-1.336.252.038.503.083.756.107.234.022.479.255.795.003-2.179-1.574-4.526-2.096-7.094-1.872Zm-10.049-9.544c1.475.051 2.943-.142 4.486-1.059-.452.04-.643.04-.827.076-2.126.424-4.033-.04-5.733-1.383-.623-.493-1.257-.974-1.889-1.457-2.503-1.914-5.374-2.555-8.514-2.5.05.154.054.26.108.315 3.417 3.455 7.371 5.836 12.369 6.008Zm24.727 17.731c-2.114-2.097-4.952-2.367-7.578-.537 1.738.078 3.043.632 4.101 1.728.374.388.763.768 1.182 1.106 1.6 1.29 4.311 1.352 5.896.155-1.861-.726-1.861-.726-3.601-2.452Zm-21.058 16.06c-1.858-3.46-4.981-4.24-8.59-4.008a9.667 9.667 0 0 1 2.977 1.39c.84.586 1.547 1.311 2.243 2.055 1.38 1.473 3.534 2.376 4.962 2.07-.656-.412-1.238-.848-1.592-1.507Zm17.29-19.32c0-.023.001-.045.003-.068l-.006.006.006-.006-.036-.004.021.018.012.053Zm-20 14.744a7.61 7.61 0 0 0-.072-.041.127.127 0 0 0 .015.043c.005.008.038 0 .058-.002Zm-.072-.041-.008-.034-.008.01.008-.01-.022-.006.005.026.024.014Z"
          fill="currentColor"
        />
      </svg>
      <span class="text-muted-foreground text-lg font-light select-none">+</span>
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 256" class="h-5 text-foreground" aria-hidden="true">
        <line x1="208" y1="128" x2="128" y2="208" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32" />
        <line x1="192" y1="40" x2="40" y2="192" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32" />
      </svg>
    </span>
    """
  end

  # ── Shared header & footer ──────────────────────────────────────────

  attr :current, :string, default: nil

  defp site_header(assigns) do
    assigns = assign(assigns, :github_url, "https://github.com/bumbus/phx_shadcn")
    ~H"""
    <header class="sticky top-0 z-60 flex items-center justify-between border-b border-border bg-background px-4 sm:px-6 lg:px-8 h-14">
      <div class="flex items-center gap-6">
        <a href="/" class="flex items-center gap-2">
          <.logo />
          <span class="text-sm font-semibold">PhxShadcn</span>
        </a>
        <nav class="hidden sm:flex items-center gap-4 text-sm">
          <a href="/" class={nav_link_class(@current == "home")}>Home</a>
          <a href="/showcase" class={nav_link_class(@current == "showcase")}>Showcase</a>
          <a href="/storybook" class={nav_link_class(@current == "storybook")}>Storybook</a>
        </nav>
      </div>
      <div class="flex items-center gap-2">
        <a
          href={@github_url}
          target="_blank"
          rel="noopener"
          class="inline-flex items-center justify-center size-9 rounded-md text-muted-foreground hover:text-foreground hover:bg-accent"
          title="GitHub"
        >
          <svg viewBox="0 0 24 24" aria-hidden="true" class="size-5 fill-current">
            <path d="M12 0C5.37 0 0 5.506 0 12.303c0 5.445 3.435 10.043 8.205 11.674.6.107.825-.262.825-.585 0-.292-.015-1.261-.015-2.291C6 21.67 5.22 20.346 4.98 19.654c-.135-.354-.72-1.446-1.23-1.738-.42-.23-1.02-.8-.015-.815.945-.015 1.62.892 1.845 1.261 1.08 1.86 2.805 1.338 3.495 1.015.105-.8.42-1.338.765-1.645-2.67-.308-5.46-1.37-5.46-6.075 0-1.338.465-2.446 1.23-3.307-.12-.308-.54-1.569.12-3.26 0 0 1.005-.323 3.3 1.26.96-.276 1.98-.415 3-.415s2.04.139 3 .416c2.295-1.6 3.3-1.261 3.3-1.261.66 1.691.24 2.952.12 3.26.765.861 1.23 1.953 1.23 3.307 0 4.721-2.805 5.767-5.475 6.075.435.384.81 1.122.81 2.276 0 1.645-.015 2.968-.015 3.383 0 .323.225.707.825.585a12.047 12.047 0 0 0 5.919-4.489A12.536 12.536 0 0 0 24 12.304C24 5.505 18.63 0 12 0Z" />
          </svg>
        </a>
        <.theme_toggle />
        <button
          :if={@current == "showcase"}
          class="md:hidden inline-flex items-center justify-center size-9 rounded-md text-muted-foreground hover:text-foreground hover:bg-accent cursor-pointer"
          phx-click={PhxShadcn.JS.show("mobile-nav")}
          aria-label="Open menu"
        >
          <.icon name="hero-bars-3-micro" class="size-5" />
        </button>
      </div>
    </header>
    """
  end

  defp nav_link_class(true), do: "font-medium text-foreground"
  defp nav_link_class(false), do: "text-muted-foreground hover:text-foreground"

  defp site_footer(assigns) do
    assigns = assign(assigns, :github_url, "https://github.com/bumbus/phx_shadcn")
    ~H"""
    <footer class="border-t border-border py-6 px-4 sm:px-6 lg:px-8">
      <div class="mx-auto max-w-3xl flex items-center justify-between text-sm text-muted-foreground">
        <p>
          Built with ❤️ + <span class="text-foreground">Phoenix LiveView</span> + <span class="text-foreground">shadcn/ui</span>
        </p>
        <a
          href={@github_url}
          target="_blank"
          rel="noopener"
          class="inline-flex items-center hover:text-foreground"
          title="GitHub"
        >
          <svg viewBox="0 0 24 24" aria-hidden="true" class="size-5 fill-current">
            <path d="M12 0C5.37 0 0 5.506 0 12.303c0 5.445 3.435 10.043 8.205 11.674.6.107.825-.262.825-.585 0-.292-.015-1.261-.015-2.291C6 21.67 5.22 20.346 4.98 19.654c-.135-.354-.72-1.446-1.23-1.738-.42-.23-1.02-.8-.015-.815.945-.015 1.62.892 1.845 1.261 1.08 1.86 2.805 1.338 3.495 1.015.105-.8.42-1.338.765-1.645-2.67-.308-5.46-1.37-5.46-6.075 0-1.338.465-2.446 1.23-3.307-.12-.308-.54-1.569.12-3.26 0 0 1.005-.323 3.3 1.26.96-.276 1.98-.415 3-.415s2.04.139 3 .416c2.295-1.6 3.3-1.261 3.3-1.261.66 1.691.24 2.952.12 3.26.765.861 1.23 1.953 1.23 3.307 0 4.721-2.805 5.767-5.475 6.075.435.384.81 1.122.81 2.276 0 1.645-.015 2.968-.015 3.383 0 .323.225.707.825.585a12.047 12.047 0 0 0 5.919-4.489A12.536 12.536 0 0 0 24 12.304C24 5.505 18.63 0 12 0Z" />
          </svg>
        </a>
      </div>
    </footer>
    """
  end

  # ── Showcase layout ──────────────────────────────────────────────────

  @doc """
  Layout for the showcase section: sticky header + sidebar (theme switcher
  + component nav) + scrollable main area.
  """
  attr(:flash, :map, required: true)
  attr(:current_scope, :map, default: nil)
  attr(:current_path, :string, default: nil)
  attr(:inner_content, :any, default: nil)
  slot(:inner_block)

  def showcase(assigns) do
    ~H"""
    <.site_header current="showcase" />

    <%!-- Mobile menu sheet --%>
    <.sheet id="mobile-nav" side={:right} class="w-72 p-0" on_cancel={PhxShadcn.JS.hide("mobile-nav")}>
      <div class="flex flex-col gap-6 p-4 overflow-y-auto h-full">
        <nav class="flex flex-col gap-1">
          <a href="/" class="rounded-md px-2 py-1.5 text-sm font-medium text-muted-foreground hover:text-foreground hover:bg-accent">Home</a>
          <a href="/storybook" class="rounded-md px-2 py-1.5 text-sm font-medium text-muted-foreground hover:text-foreground hover:bg-accent">Storybook</a>
        </nav>
        <.separator />
        <.sidebar_nav current_path={@current_path} id_suffix="-mobile" />
      </div>
    </.sheet>

    <div class="flex flex-1">
      <%!-- Desktop sidebar --%>
      <aside class="hidden md:flex w-64 shrink-0 flex-col gap-6 border-r border-border p-4 sticky top-14 h-[calc(100vh-3.5rem)] overflow-y-auto">
        <.sidebar_nav current_path={@current_path} />
      </aside>

      <%!-- Main content --%>
      <main class="flex-1 min-w-0 overflow-x-hidden p-4 sm:p-6 lg:p-10">
        <div class="mx-auto max-w-3xl">
          {@inner_content}
        </div>
      </main>
    </div>

    <.site_footer />
    <.toaster flash={@flash} />
    """
  end

  # ── Sidebar nav (shared between desktop aside and mobile sheet) ────

  attr :current_path, :string, default: nil
  attr :id_suffix, :string, default: ""
  attr :show_theme, :boolean, default: true

  defp sidebar_nav(assigns) do
    ~H"""
    <%!-- Theme Switcher --%>
    <div :if={@show_theme} id={"theme-switcher#{@id_suffix}"} phx-hook="ThemeSwitcher" phx-update="ignore">
      <h3 class="mb-3 text-xs font-semibold uppercase tracking-wider text-muted-foreground">
        Theme
      </h3>

      <%!-- Color presets --%>
      <div class="mb-3">
        <span class="text-xs text-muted-foreground">Color</span>
        <div class="mt-1.5 flex flex-wrap gap-1.5">
          <.preset_swatch preset="zinc" label="Zinc" />
          <.preset_swatch preset="slate" label="Slate" />
          <.preset_swatch preset="rose" label="Rose" />
          <.preset_swatch preset="blue" label="Blue" />
          <.preset_swatch preset="green" label="Green" />
          <.preset_swatch preset="violet" label="Violet" />
        </div>
      </div>

      <%!-- Radius --%>
      <div class="mb-3">
        <div class="flex items-center justify-between">
          <span class="text-xs text-muted-foreground">Radius</span>
          <span data-radius-label class="text-xs text-muted-foreground">0.63rem</span>
        </div>
        <input
          type="range"
          data-radius-input
          min="0"
          max="1"
          step="0.05"
          class="mt-1.5 w-full accent-primary"
        />
      </div>

      <%!-- Mode --%>
      <div>
        <span class="text-xs text-muted-foreground">Mode</span>
        <div class="mt-1.5 flex gap-1.5">
          <button
            data-mode="light"
            class="inline-flex items-center justify-center gap-1.5 rounded-md border border-input px-2.5 py-1 text-xs cursor-pointer hover:bg-accent data-[active=true]:border-primary data-[active=true]:bg-accent"
          >
            <.icon name="hero-sun-micro" class="size-3.5" /> Light
          </button>
          <button
            data-mode="dark"
            class="inline-flex items-center justify-center gap-1.5 rounded-md border border-input px-2.5 py-1 text-xs cursor-pointer hover:bg-accent data-[active=true]:border-primary data-[active=true]:bg-accent"
          >
            <.icon name="hero-moon-micro" class="size-3.5" /> Dark
          </button>
        </div>
      </div>
    </div>

    <.separator :if={@show_theme} />

    <%!-- Component nav --%>
    <nav class="flex flex-col gap-4">
      <div>
        <div class="flex flex-col">
          <.sidebar_link href="/showcase" label="Overview" current_path={@current_path} />
          <.sidebar_link href="/showcase/forms" label="Forms" current_path={@current_path} />
          <.sidebar_link href="/showcase/js-events" label="JS Events" current_path={@current_path} />
          <.sidebar_link href="/showcase/kitchen-sink" label="Kitchen Sink" current_path={@current_path} />
        </div>
      </div>

      <.sidebar_group title="Tier 1 — Static">
        <.sidebar_link href="/showcase/kitchen-sink#alert" label="Alert" current_path={@current_path} />
        <.sidebar_link href="/showcase/kitchen-sink#aspect-ratio" label="AspectRatio" current_path={@current_path} />
        <.sidebar_link href="/showcase/kitchen-sink#avatar" label="Avatar" current_path={@current_path} />
        <.sidebar_link href="/showcase/kitchen-sink#badge" label="Badge" current_path={@current_path} />
        <.sidebar_link href="/showcase/kitchen-sink#breadcrumb" label="Breadcrumb" current_path={@current_path} />
        <.sidebar_link href="/storybook/checkbox" label="Checkbox" current_path={@current_path} />
        <.sidebar_link href="/showcase/kitchen-sink#button" label="Button" current_path={@current_path} />
        <.sidebar_link href="/showcase/kitchen-sink#card" label="Card" current_path={@current_path} />
        <.sidebar_link href="/showcase/kitchen-sink#input" label="Input" current_path={@current_path} />
        <.sidebar_link href="/showcase/kitchen-sink#label" label="Label" current_path={@current_path} />
        <.sidebar_link href="/showcase/kitchen-sink#native-select" label="NativeSelect" current_path={@current_path} />
        <.sidebar_link href="/showcase/kitchen-sink#pagination" label="Pagination" current_path={@current_path} />
        <.sidebar_link href="/showcase/kitchen-sink#separator" label="Separator" current_path={@current_path} />
        <.sidebar_link href="/showcase/kitchen-sink#skeleton" label="Skeleton" current_path={@current_path} />
        <.sidebar_link href="/showcase/kitchen-sink#table" label="Table" current_path={@current_path} />
        <.sidebar_link href="/showcase/kitchen-sink#textarea" label="Textarea" current_path={@current_path} />
      </.sidebar_group>

      <.sidebar_group title="Tier 2 — Interactive">
        <.sidebar_link href="/showcase/accordion" label="Accordion" current_path={@current_path} />
        <.sidebar_link href="/showcase/collapsible" label="Collapsible" current_path={@current_path} />
        <.sidebar_link href="/showcase/input-otp" label="InputOTP" current_path={@current_path} />
        <.sidebar_link href="/showcase/toggle" label="Toggle" current_path={@current_path} />
        <.sidebar_link href="/showcase/switch" label="Switch" current_path={@current_path} />
        <.sidebar_link href="/showcase/progress" label="Progress" current_path={@current_path} />
        <.sidebar_link href="/showcase/radio-group" label="RadioGroup" current_path={@current_path} />
        <.sidebar_link href="/showcase/scroll-area" label="ScrollArea" current_path={@current_path} />
        <.sidebar_link href="/showcase/slider" label="Slider" current_path={@current_path} />
        <.sidebar_link href="/showcase/tabs" label="Tabs" current_path={@current_path} />
      </.sidebar_group>

      <.sidebar_group title="Tier 3 — Overlay">
        <.sidebar_link href="/showcase/alert-dialog" label="AlertDialog" current_path={@current_path} />
        <.sidebar_link href="/showcase/dialog" label="Dialog" current_path={@current_path} />
        <.sidebar_link href="/showcase/sheet" label="Sheet" current_path={@current_path} />
        <.sidebar_link href="/showcase/popover" label="Popover" current_path={@current_path} />
        <.sidebar_link href="/showcase/tooltip" label="Tooltip" current_path={@current_path} />
        <.sidebar_link href="/showcase/hover-card" label="HoverCard" current_path={@current_path} />
        <.sidebar_link href="/showcase/toast" label="Toast" current_path={@current_path} />
      </.sidebar_group>

      <.sidebar_group title="Tier 4 — Complex">
        <.sidebar_link href="/showcase/select" label="Select" current_path={@current_path} />
        <.sidebar_link href="/showcase/context-menu" label="ContextMenu" current_path={@current_path} />
        <.sidebar_link href="/showcase/dropdown-menu" label="DropdownMenu" current_path={@current_path} />
        <.sidebar_link href="/showcase/menubar" label="Menubar" current_path={@current_path} />
      </.sidebar_group>
    </nav>
    """
  end

  # ── Sidebar helpers ──────────────────────────────────────────────────

  attr(:title, :string, required: true)
  slot(:inner_block, required: true)

  defp sidebar_group(assigns) do
    ~H"""
    <div>
      <h4 class="mb-1 text-xs font-semibold uppercase tracking-wider text-muted-foreground">
        {@title}
      </h4>
      <div class="flex flex-col">
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  attr(:href, :string, required: true)
  attr(:label, :string, required: true)
  attr(:current_path, :string, default: nil)

  defp sidebar_link(assigns) do
    # Compare the path portion of href (strip fragment) against current_path
    link_path = assigns.href |> String.split("#") |> List.first()
    has_fragment = String.contains?(assigns.href, "#")
    fragment = if has_fragment, do: assigns.href |> String.split("#") |> List.last(), else: nil

    assigns =
      assigns
      |> assign(:active, link_path == assigns.current_path)
      |> assign(:has_fragment, has_fragment)
      |> assign(:fragment, fragment)
      |> assign(:link_path, link_path)

    ~H"""
    <.link
      :if={!@has_fragment}
      navigate={@href}
      class={[
        "rounded-md px-2 py-1 text-sm",
        if(@active,
          do: "font-medium text-foreground bg-accent",
          else: "text-muted-foreground hover:text-foreground hover:bg-accent"
        )
      ]}
    >
      {@label}
    </.link>
    <a
      :if={@has_fragment}
      href={@href}

      class={[
        "rounded-md px-2 py-1 text-sm",
        if(@active,
          do: "font-medium text-foreground bg-accent",
          else: "text-muted-foreground hover:text-foreground hover:bg-accent"
        )
      ]}
    >
      {@label}
    </a>
    """
  end

  attr(:preset, :string, required: true)
  attr(:label, :string, required: true)

  defp preset_swatch(assigns) do
    ~H"""
    <button
      data-preset={@preset}
      title={@label}
      class="size-6 rounded-full border-2 border-transparent cursor-pointer ring-offset-background data-[active=true]:border-primary"
      style={swatch_style(@preset)}
    >
      <span class="sr-only">{@label}</span>
    </button>
    """
  end

  defp swatch_style("zinc"), do: "background: oklch(0.552 0 0)"
  defp swatch_style("slate"), do: "background: oklch(0.554 0.022 264.695)"
  defp swatch_style("rose"), do: "background: oklch(0.586 0.254 17.585)"
  defp swatch_style("blue"), do: "background: oklch(0.546 0.245 262.881)"
  defp swatch_style("green"), do: "background: oklch(0.596 0.145 163.225)"
  defp swatch_style("violet"), do: "background: oklch(0.541 0.281 293.009)"
  defp swatch_style(_), do: "background: oklch(0.5 0 0)"
end
