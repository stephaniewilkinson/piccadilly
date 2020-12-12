defmodule Piccadilly.Repo.Migrations.RemovePostsUsername do
  use Ecto.Migration

  def up do
    alter table(:posts) do
      remove :username
    end
  end
  def down do
    alter table(:posts) do
      add :username, :string
    end
  end
end
