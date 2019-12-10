defmodule PersonalSiteWeb.PageController do
  use PersonalSiteWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def portfolio(conn, _params) do
    render conn, "portfolio.html"
  end
end
