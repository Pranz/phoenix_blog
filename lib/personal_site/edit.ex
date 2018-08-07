defmodule PersonalSite.Edit do
  use Ecto.Schema
  import Ecto.Changeset


  schema "edits" do
    field :diff, :string
    field :message, :string
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(edit, attrs) do
    edit
    |> cast(attrs, [:message, :diff])
    |> validate_required([:message, :diff])
  end
end
