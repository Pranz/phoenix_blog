defmodule PersonalSite.Repo.Migrations.CreateEdits do
  use Ecto.Migration

  def change do
    create table(:edits) do
      add :message, :text
      add :diff, :text
      add :post_id, references(:posts, on_delete: :delete_all)

      timestamps()
    end

    create index(:edits, [:post_id])
  end
end
