defmodule PhxShadcnDevWeb.Components.Showcase.EventLog do
  use Phoenix.Component
  use PhxShadcn

  @doc """
  A card displaying a list of event log entries with a clear button.

  The clear button fires `phx-click="clear-log"` — the parent LiveView must handle it.
  """
  attr :entries, :list, required: true
  attr :empty_message, :string, default: "Toggle an item above to see events appear here."

  def event_log(assigns) do
    ~H"""
    <.card>
      <.card_header>
        <.card_title class="flex items-center justify-between text-sm">
          Event Log
          <.button variant="ghost" size="sm" phx-click="clear-log">Clear</.button>
        </.card_title>
      </.card_header>
      <.card_content>
        <div :if={@entries == []} class="text-sm text-muted-foreground">
          {@empty_message}
        </div>
        <ul :if={@entries != []} class="space-y-1 font-mono text-xs">
          <li :for={entry <- @entries} class="text-muted-foreground">{entry}</li>
        </ul>
      </.card_content>
    </.card>
    """
  end
end
