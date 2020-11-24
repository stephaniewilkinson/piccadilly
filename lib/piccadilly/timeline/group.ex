defmodule Piccadilly.Timeline.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :description, :string
    field :emoji, :string
    field :name, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :description, :emoji])
    |> validate_required([:name, :description, :emoji])
  end
end
