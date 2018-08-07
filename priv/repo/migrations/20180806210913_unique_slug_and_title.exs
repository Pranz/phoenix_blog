defmodule PersonalSite.Repo.Migrations.UniqueSlugAndTitle do
  use Ecto.Migration

  def change do

    create(unique_index :posts, [:slug])
  end
end
