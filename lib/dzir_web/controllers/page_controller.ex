defmodule DzirWeb.PageController do
  use DzirWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home)
  end

  def next(conn, _params) do
    referer =
      conn
      |> Plug.Conn.get_req_header("referer")
      |> List.first()

    conn
    |> redirect(external: Dzir.Webring.next(referer))
  end

  def prev(conn, _params) do
    referer =
      conn
      |> Plug.Conn.get_req_header("referer")
      |> List.first()

    conn
    |> redirect(external: Dzir.Webring.prev(referer))
  end

  def rand(conn, _params) do
    conn
    |> redirect(external: Dzir.Webring.random())
  end

  def websites(conn, params) do
    conn
    |> assign(:page, String.to_integer(params["page"]))
    |> render(:websites)
  end
end
