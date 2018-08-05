defmodule PersonalSiteWeb.PostController do
  use PersonalSiteWeb, :controller
  import Plug.Conn
  import Ecto.Query, only: [from: 2]

  alias PersonalSite.Repo
  alias PersonalSite.Post
  alias PersonalSiteWeb.PostController.Helper
  alias PersonalSiteWeb.ControllerHelper

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{"id" => slug}) do
    post = Repo.get_by!(Post, slug: slug)
    render conn, ControllerHelper.extend_filename(conn, "show"), post: post
  end

  def create(conn, _params) do
    {:ok, data, _conn_details} = conn |> read_body
    {metadata, html, markdown} = Helper.parse_markdown(data)
    [title, published_at] = metadata |> Helper.get_props(['title', 'published_at'])
    date = Timex.parse!(published_at, "%Y-%m-%d", :strftime)
    Repo.insert(%Post{
      title: title,
      published_at: date,
      last_edited_at: date,
      source: markdown,
      html: html,
      slug: Slugger.slugify title
    })
    json conn, %{
      status: "created"
    }
  end

end

defmodule PersonalSiteWeb.PostController.Helper do
  def parse_markdown(data) do
    [frontmatter, markdown] = String.split(data, ~r/\n-{3,}\n/, parts: 2)
    {parse_yaml(frontmatter), Earmark.as_html!(markdown), markdown}
  end

  def parse_yaml(data) do
    [parsed] = :yamerl_constr.string(data)
    parsed
  end

  def get_props(proplist, selectors) do
    selectors
      |> Enum.map(
        fn x ->
          to_string(:proplists.get_value(x, proplist))
        end
      )
  end
end
