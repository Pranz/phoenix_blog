defmodule PersonalSite.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :source, :string
    field :slug, :string
    field :published_at, Timex.Ecto.Date
    field :last_edited_at, Timex.Ecto.Date
    field :html, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :source, :slug, :published_at, :last_edited_at, :html])
    |> unique_constraint(:slug)
    |> validate_required([:title, :source, :slug, :published_at, :last_edited_at, :html])
  end
end
