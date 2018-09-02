---
title: Making a simple feedback form in Phoenix
published_at: 2018-08-12
series: Making of this blog
part: 2
---

I'm currently working on a comprehensive CSS grid guide, which will be made in several parts. It
occured to me that it would be nice to have a direct and simple way for readers to give feedback
right inside the article, because I don't know anything about writing and I'm sure I could learn
a lot from it. I could also ask questions about what people struggled with in understanding grid,
or answer questions directly.

### Why not comments?
Comments can be a fantastic addition and something I plan on doing, but it will take some time to
do right. A comment section where everything is visible might also discourage some readers.
With this system, I intend on making questions (and only questions) public at the end when I have answered them, sort of like an FAQ.

Particularly, would like to make it so that you could highlight a piece of text and directly post a comment, and also integrate the system with ActivityPub, which I have no idea how to do at the moment. Will require some research!

{: .aside}

### Generating the model
Phoenix has a quick way to generate the boilerplate code for a model.

```
mix phx.gen.schema Feedback feedback
  post_id:references:posts body:text type:string
```

This will generate a model along with a migration. I want every piece of feedback be tied to a post so I can easily get all feedback posted on a particular post. The model will look something like this:

```
defmodule PersonalSite.Feedback do
  use Ecto.Schema
  import Ecto.Changeset


  schema "feedback" do
    field :body, :string
    field :type, :string
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(feedback, attrs) do
    feedback
    |> cast(attrs, [:body, :type])
    |> validate_required([:body, :type, :post_id])
  end
end
```

This all looks good to me, so lets run the migration with `mix ecto.migrate`. Lets also edit our `router.ex`

```
  scope "/", PersonalSiteWeb do
    ...omitted previous routes
    resources "/feedback", PostController,
      only: [:index, :create]
  end
```

`resources` is a macro that will make a whole lot of routes for creating, showing a single one, editing e.t.c. But here i provide the `only` option, saying that I only want an index route, and a
route for creating. You can see what routes phoenix generates with `mix phx.routes`.

```
> mix phx.routes
  ...omitted previous routes
  post_path  GET     /feedback       PersonalSiteWeb.PostController :index
  post_path  POST    /feedback       PersonalSiteWeb.PostController :create
```

I like how declerative and readable the code so far been. Now it's time to write the `PostController` which will actually do all the work. It's also pretty straightforward:

```
defmodule PersonalSiteWeb.FeedbackController do
    use PersonalSiteWeb, :controller
    import Plug.Conn
    alias PersonalSite.Repo
    alias PersonalSite.Feedback

    def create(conn, params) do
      res = params
        |> Feedback.changeset(%Feedback{})
        |> Repo.insert!

      case res do
        {:ok, _} -> json conn, %{ status: "created" }
        _ -> send_resp conn, 400, "requires body and topic"
      end
      json conn, %{ status: "created" }
    end

end
```
