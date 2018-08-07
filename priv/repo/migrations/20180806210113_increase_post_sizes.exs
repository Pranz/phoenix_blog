defmodule PersonalSite.Repo.Migrations.IncreasePostSizes do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      modify :source, :text
      modify :html, :text
    end
  end
end
