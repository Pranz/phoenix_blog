
defmodule PersonalSiteWeb.PostView do
  use PersonalSiteWeb, :view

  def render("show.json", %{post: post}) do
    render_one(post, PersonalSiteWeb.PostView, "post.json")
  end

  def render("post.json", %{post: post}) do
    %{
      title: post.title,
      published_at: post.published_at,
      last_edited_at: post.last_edited_at,
      html: post.html
    }
  end
end
