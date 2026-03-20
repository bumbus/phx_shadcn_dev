defmodule PhxShadcnDevWeb.ShowcaseLive.KitchenSink do
  use PhxShadcnDevWeb, :live_view
  use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Kitchen Sink")}
  end

  # ── Examples (source extracted at compile time) ─────────────────────

  defp example_alert(assigns) do
    ~H"""
    <.alert>
      <.alert_title>Heads up!</.alert_title>
      <.alert_description>You can add components to your app using the CLI.</.alert_description>
    </.alert>

    <.alert variant="destructive">
      <.alert_title>Error</.alert_title>
      <.alert_description>Something went wrong. Please try again.</.alert_description>
    </.alert>
    """
  end

  defp example_aspect_ratio(assigns) do
    ~H"""
    <div class="grid gap-4 sm:grid-cols-2">
      <div>
        <p class="mb-2 text-sm text-muted-foreground">16:9</p>
        <.aspect_ratio ratio={16 / 9} class="overflow-hidden rounded-md bg-muted">
          <div class="flex size-full items-center justify-center text-sm text-muted-foreground">
            16:9
          </div>
        </.aspect_ratio>
      </div>
      <div>
        <p class="mb-2 text-sm text-muted-foreground">1:1</p>
        <.aspect_ratio ratio={1.0} class="w-32 overflow-hidden rounded-md bg-muted">
          <div class="flex size-full items-center justify-center text-sm text-muted-foreground">
            1:1
          </div>
        </.aspect_ratio>
      </div>
    </div>
    """
  end

  defp example_avatar(assigns) do
    ~H"""
    <div class="flex items-center gap-4">
      <.avatar>
        <.avatar_image src="https://github.com/shadcn.png" alt="shadcn" />
        <.avatar_fallback>CN</.avatar_fallback>
      </.avatar>
      <.avatar>
        <.avatar_fallback>JD</.avatar_fallback>
      </.avatar>
      <.avatar size="sm">
        <.avatar_fallback>S</.avatar_fallback>
      </.avatar>
      <.avatar size="lg">
        <.avatar_fallback>LG</.avatar_fallback>
      </.avatar>
    </div>
    """
  end

  defp example_badge(assigns) do
    ~H"""
    <div class="flex flex-wrap gap-2">
      <.badge>Default</.badge>
      <.badge variant="secondary">Secondary</.badge>
      <.badge variant="destructive">Destructive</.badge>
      <.badge variant="outline">Outline</.badge>
      <.badge variant="ghost">Ghost</.badge>
      <.badge variant="link">Link</.badge>
    </div>
    """
  end

  defp example_breadcrumb(assigns) do
    ~H"""
    <.breadcrumb>
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
          <.breadcrumb_link href="/showcase">Components</.breadcrumb_link>
        </.breadcrumb_item>
        <.breadcrumb_separator />
        <.breadcrumb_item>
          <.breadcrumb_page>Kitchen Sink</.breadcrumb_page>
        </.breadcrumb_item>
      </.breadcrumb_list>
    </.breadcrumb>
    """
  end

  defp example_button(assigns) do
    ~H"""
    <div class="space-y-4">
      <div class="flex flex-wrap items-center gap-2">
        <.button>Default</.button>
        <.button variant="destructive">Destructive</.button>
        <.button variant="outline">Outline</.button>
        <.button variant="secondary">Secondary</.button>
        <.button variant="ghost">Ghost</.button>
        <.button variant="link">Link</.button>
      </div>
      <div class="flex flex-wrap items-center gap-2">
        <.button size="xs">Extra Small</.button>
        <.button size="sm">Small</.button>
        <.button size="default">Default</.button>
        <.button size="lg">Large</.button>
        <.button size="icon" variant="outline">X</.button>
      </div>
      <div class="flex flex-wrap items-center gap-2">
        <.button disabled>Disabled</.button>
        <.button variant="outline">Inbox <.badge variant="secondary">99+</.badge></.button>
      </div>
    </div>
    """
  end

  defp example_card(assigns) do
    ~H"""
    <div class="grid gap-4 sm:grid-cols-2">
      <.card>
        <.card_header>
          <.card_title>Card Title</.card_title>
          <.card_description>Card description goes here.</.card_description>
        </.card_header>
        <.card_content>
          <p>Card content with some text.</p>
        </.card_content>
      </.card>

      <.card>
        <.card_header>
          <.card_title>Account</.card_title>
          <.card_description>Manage your account settings.</.card_description>
        </.card_header>
        <.card_content>
          <p>Your plan: <strong>Pro</strong></p>
        </.card_content>
        <.card_footer>
          <.button size="sm">Save changes</.button>
        </.card_footer>
      </.card>
    </div>
    """
  end

  defp example_input(assigns) do
    ~H"""
    <div class="grid max-w-sm gap-3">
      <.input placeholder="Email" />
      <.input type="password" placeholder="Password" />
      <.input type="file" />
      <.input placeholder="Disabled" disabled />
    </div>
    """
  end

  defp example_label(assigns) do
    ~H"""
    <div class="grid max-w-sm gap-2">
      <.label>Email</.label>
      <.input type="email" placeholder="you@example.com" />
    </div>
    """
  end

  defp example_pagination(assigns) do
    ~H"""
    <.pagination>
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
    </.pagination>
    """
  end

  defp example_separator(assigns) do
    ~H"""
    <div class="space-y-4">
      <div>
        <p class="text-sm text-muted-foreground">Horizontal</p>
        <.separator class="my-2" />
      </div>
      <div class="flex h-8 items-center gap-4">
        <span class="text-sm">Left</span>
        <.separator orientation="vertical" />
        <span class="text-sm">Right</span>
      </div>
    </div>
    """
  end

  defp example_skeleton(assigns) do
    ~H"""
    <div class="flex items-center gap-4">
      <.skeleton class="h-12 w-12 rounded-full" />
      <div class="space-y-2">
        <.skeleton class="h-4 w-48" />
        <.skeleton class="h-4 w-32" />
      </div>
    </div>
    """
  end

  defp example_table(assigns) do
    ~H"""
    <.table>
      <.table_caption>A list of your recent invoices.</.table_caption>
      <.table_header>
        <.table_row>
          <.table_head>Invoice</.table_head>
          <.table_head>Status</.table_head>
          <.table_head>Method</.table_head>
          <.table_head class="text-right">Amount</.table_head>
        </.table_row>
      </.table_header>
      <.table_body>
        <.table_row>
          <.table_cell class="font-medium">INV001</.table_cell>
          <.table_cell>Paid</.table_cell>
          <.table_cell>Credit Card</.table_cell>
          <.table_cell class="text-right">$250.00</.table_cell>
        </.table_row>
        <.table_row>
          <.table_cell class="font-medium">INV002</.table_cell>
          <.table_cell>Pending</.table_cell>
          <.table_cell>PayPal</.table_cell>
          <.table_cell class="text-right">$150.00</.table_cell>
        </.table_row>
        <.table_row>
          <.table_cell class="font-medium">INV003</.table_cell>
          <.table_cell>Unpaid</.table_cell>
          <.table_cell>Bank Transfer</.table_cell>
          <.table_cell class="text-right">$350.00</.table_cell>
        </.table_row>
      </.table_body>
      <.table_footer>
        <.table_row>
          <.table_cell>Total</.table_cell>
          <.table_cell></.table_cell>
          <.table_cell></.table_cell>
          <.table_cell class="text-right">$750.00</.table_cell>
        </.table_row>
      </.table_footer>
    </.table>
    """
  end

  defp example_native_select(assigns) do
    ~H"""
    <div class="grid max-w-sm gap-3">
      <.native_select
        prompt="Select a fruit"
        options={[{"Apple", "apple"}, {"Banana", "banana"}, {"Cherry", "cherry"}]}
      />

      <.native_select size="sm"
        prompt="Small size"
        options={[{"Option A", "a"}, {"Option B", "b"}]}
      />

      <.native_select disabled
        prompt="Disabled"
        options={[{"Apple", "apple"}]}
      />

      <.native_select>
        <.native_select_option value="">With groups</.native_select_option>
        <.native_select_optgroup label="Fruits">
          <.native_select_option value="apple">Apple</.native_select_option>
          <.native_select_option value="banana">Banana</.native_select_option>
        </.native_select_optgroup>
        <.native_select_optgroup label="Vegetables">
          <.native_select_option value="carrot">Carrot</.native_select_option>
          <.native_select_option value="spinach">Spinach</.native_select_option>
        </.native_select_optgroup>
      </.native_select>
    </div>
    """
  end

  defp example_textarea(assigns) do
    ~H"""
    <div class="grid max-w-sm gap-3">
      <.textarea placeholder="Type your message here." />
      <.textarea placeholder="Disabled" disabled />
    </div>
    """
  end

  # ── Render ──────────────────────────────────────────────────────────

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-10">
      <.showcase_header title="Kitchen Sink">
        All Tier 1 (static) components in one page. Jump to a section using the sidebar links.
      </.showcase_header>

      <.separator />

      <div id="alert" class="scroll-mt-20">
        <.demo_section title="Alert" code={showcase_source(:example_alert)} storybook="/storybook/alert">
          {example_alert(assigns)}
        </.demo_section>
      </div>

      <div id="aspect-ratio" class="scroll-mt-20">
        <.demo_section title="AspectRatio" code={showcase_source(:example_aspect_ratio)} storybook="/storybook/aspect_ratio">
          {example_aspect_ratio(assigns)}
        </.demo_section>
      </div>

      <div id="avatar" class="scroll-mt-20">
        <.demo_section title="Avatar" code={showcase_source(:example_avatar)} storybook="/storybook/avatar">
          {example_avatar(assigns)}
        </.demo_section>
      </div>

      <div id="badge" class="scroll-mt-20">
        <.demo_section title="Badge" code={showcase_source(:example_badge)} storybook="/storybook/badge">
          {example_badge(assigns)}
        </.demo_section>
      </div>

      <div id="breadcrumb" class="scroll-mt-20">
        <.demo_section title="Breadcrumb" code={showcase_source(:example_breadcrumb)} storybook="/storybook/breadcrumb">
          {example_breadcrumb(assigns)}
        </.demo_section>
      </div>

      <div id="button" class="scroll-mt-20">
        <.demo_section title="Button" code={showcase_source(:example_button)} storybook="/storybook/button">
          {example_button(assigns)}
        </.demo_section>
      </div>

      <div id="card" class="scroll-mt-20">
        <.demo_section title="Card" code={showcase_source(:example_card)} storybook="/storybook/card">
          {example_card(assigns)}
        </.demo_section>
      </div>

      <div id="input" class="scroll-mt-20">
        <.demo_section title="Input" code={showcase_source(:example_input)} storybook="/storybook/input">
          {example_input(assigns)}
        </.demo_section>
      </div>

      <div id="native-select" class="scroll-mt-20">
        <.demo_section title="NativeSelect" code={showcase_source(:example_native_select)} storybook="/storybook/native_select">
          {example_native_select(assigns)}
        </.demo_section>
      </div>

      <div id="label" class="scroll-mt-20">
        <.demo_section title="Label" code={showcase_source(:example_label)} storybook="/storybook/label">
          {example_label(assigns)}
        </.demo_section>
      </div>

      <div id="pagination" class="scroll-mt-20">
        <.demo_section title="Pagination" code={showcase_source(:example_pagination)} storybook="/storybook/pagination">
          {example_pagination(assigns)}
        </.demo_section>
      </div>

      <div id="separator" class="scroll-mt-20">
        <.demo_section title="Separator" code={showcase_source(:example_separator)} storybook="/storybook/separator">
          {example_separator(assigns)}
        </.demo_section>
      </div>

      <div id="skeleton" class="scroll-mt-20">
        <.demo_section title="Skeleton" code={showcase_source(:example_skeleton)} storybook="/storybook/skeleton">
          {example_skeleton(assigns)}
        </.demo_section>
      </div>

      <div id="table" class="scroll-mt-20">
        <.demo_section title="Table" code={showcase_source(:example_table)} storybook="/storybook/table">
          {example_table(assigns)}
        </.demo_section>
      </div>

      <div id="textarea" class="scroll-mt-20">
        <.demo_section title="Textarea" code={showcase_source(:example_textarea)} storybook="/storybook/textarea">
          {example_textarea(assigns)}
        </.demo_section>
      </div>
    </div>
    """
  end
end
