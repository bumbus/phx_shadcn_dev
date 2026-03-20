defmodule PhxShadcnDevWeb.Hooks.ActiveNav do
  @moduledoc """
  on_mount hook that captures the current URI path for sidebar highlighting.
  """
  import Phoenix.LiveView
  import Phoenix.Component, only: [assign: 3]

  def on_mount(:default, _params, _session, socket) do
    {:cont,
     attach_hook(socket, :active_nav, :handle_params, fn _params, uri, socket ->
       {:cont, assign(socket, :current_path, URI.parse(uri).path)}
     end)}
  end
end
