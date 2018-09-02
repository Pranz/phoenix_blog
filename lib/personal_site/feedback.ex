defmodule PersonalSite.Feedback do
  use Ecto.Schema
  import Ecto.Changeset


  schema "feedback" do
    field :body, :string
    field :type, :string, default: "general"
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(feedback, attrs) do
    feedback
    |> cast(attrs, [:post_id, :body])
    |> validate_required([:body, :post_id])
  end
end
