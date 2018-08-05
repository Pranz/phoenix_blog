defmodule PersonalSite.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :source, :string
      add :slug, :string
      add :published_at, :date
      add :last_edited_at, :date
      add :html, :string

      timestamps()
    end

    unique_index :posts, [:title]
    unique_index :posts, [:slug]
  end
end
