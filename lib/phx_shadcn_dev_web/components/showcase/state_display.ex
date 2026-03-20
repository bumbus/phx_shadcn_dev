defmodule PhxShadcnDevWeb.Components.Showcase.StateDisplay do
  use Phoenix.Component

  @doc """
  A muted bar showing the current server state value.
  """
  attr :label, :string, required: true
  attr :value, :string, required: true

  def state_display(assigns) do
    ~H"""
    <div class="rounded-md bg-muted px-3 py-2 text-sm text-muted-foreground">
      {@label}: <code class="font-mono">{@value}</code>
    </div>
    """
  end
end
