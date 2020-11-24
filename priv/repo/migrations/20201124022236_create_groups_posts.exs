defmodule Piccadilly.Repo.Migrations.CreateGroupsPosts do
  use Ecto.Migration

  def change do
    create table(:groups_posts) do
      add :group_id, references(:posts)
      add :post_id, references(:groups)
      add :inserted_at, :utc_datetime
    end

    create unique_index(:groups_posts, [:group_id, :post_id], name: :groups_posts_index)
  end
end
