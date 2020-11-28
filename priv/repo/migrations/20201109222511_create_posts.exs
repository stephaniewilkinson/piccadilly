defmodule Piccadilly.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :username, :string
      add :caption, :string
      add :image_url, :string
      add :likes_count, :integer

      timestamps()
    end

  end
end
