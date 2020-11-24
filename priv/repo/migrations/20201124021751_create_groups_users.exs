defmodule Piccadilly.Repo.Migrations.CreateGroupsUsers do
  use Ecto.Migration

  def change do
    create table(:groups_users) do
      add :group_id, references(:users)
      add :user_id, references(:groups)
    end

    create unique_index(:groups_users, [:group_id, :user_id], name: :groups_users_index)
  end
end
