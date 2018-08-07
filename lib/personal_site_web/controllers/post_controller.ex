defmodule PersonalSiteWeb.PostController do
  use PersonalSiteWeb, :controller
  import Plug.Conn
  import Ecto.Query, only: [join: 3]

  alias PersonalSite.Repo
  alias PersonalSite.Post
  alias PersonalSite.Edit
  alias PersonalSiteWeb.PostController.Helper
  alias PersonalSiteWeb.ControllerHelper

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{"id" => slug}) do
    post = Repo.get_by!(Post, slug: slug)
    edits = Repo.all(Edit, post_id: post.id)
    render conn, ControllerHelper.extend_filename(conn, "show"),
      post: post,
      edits: edits
  end

  def create(conn, _params) do
    {:ok, data, _conn_details} = conn |> read_body
    {post, edit_message} = post_from_body data
    {:ok, post} = Repo.insert post, on_conflict: :replace_all, conflict_target: :slug
    unless edit_message == nil, do: Repo.insert %Edit{
      message: edit_message,
      diff: "",
      post_id: post.id
    }
    json conn, %{
      status: "created"
    }
  end

  defp post_from_body(body) do
    {metadata, html, markdown} = Helper.parse_markdown(body)
    [title, published_at, edit_message] = metadata
      |> Helper.get_props(['title', 'published_at', 'edit_message'])
    date = Timex.parse!(published_at, "%Y-%m-%d", :strftime)
    post = %Post{
      title: title,
      published_at: date,
      last_edited_at: date,
      source: markdown,
      html: html,
      slug: Slugger.slugify title
    }

    {post, edit_message}
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
