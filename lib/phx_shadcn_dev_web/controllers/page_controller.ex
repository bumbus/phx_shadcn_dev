defmodule PhxShadcnDevWeb.PageController do
  use PhxShadcnDevWeb, :controller

  def home(conn, _params) do
    conn
    |> put_layout(html: {PhxShadcnDevWeb.Layouts, :app})
    |> render(:home)
  end
end
