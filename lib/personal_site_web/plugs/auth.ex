defmodule PersonalSiteWeb.Plug.Auth do
  alias Plug.Conn

  def init(options) do

  end

  def call(conn, _opts) do
    auth = Conn.get_req_header(conn, "Auth")
  end

end
