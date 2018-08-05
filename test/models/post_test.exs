defmodule PersonalSite.PostTest do
  use PersonalSite.ModelCase

  alias PersonalSite.Post

  @valid_attrs %{last_edited_at: ~D[2010-04-17], published_at: ~D[2010-04-17], slug: "some slug", source: "some source", title: "some title", html: "<p>test</p>"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end
end
