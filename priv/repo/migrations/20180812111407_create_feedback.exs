defmodule PersonalSite.Repo.Migrations.CreateFeedback do
  use Ecto.Migration

  def change do
    create table(:feedback) do
      add :body, :text
      add :type, :string
      add :post_id, references(:posts, on_delete: :nothing)

      timestamps()
    end

    create index(:feedback, [:post_id])
  end
end
