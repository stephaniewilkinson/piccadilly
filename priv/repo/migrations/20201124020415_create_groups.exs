defmodule Piccadilly.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string
      add :description, :string
      add :emoji, :string
      add :owner_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:groups, [:owner_id])
  end
end
