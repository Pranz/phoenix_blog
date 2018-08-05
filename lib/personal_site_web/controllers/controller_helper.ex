defmodule PersonalSiteWeb.ControllerHelper do
  import Plug.Conn
  import String, only: [contains?: 2]

  def extend_filename(conn, filename) do
    [acc] = conn |> get_req_header("accept")
    extension = cond do
      acc |> contains?("application/json") -> ".json"
      acc |> contains?("text/html") -> ".html"
      true -> ""
    end
    filename <> extension
  end
end
