defmodule Piccadilly.Repo.Migrations.RemovePostsUsername do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      remove :username
    end
  end
end
