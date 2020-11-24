defmodule Piccadilly.Timeline.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :description, :string
    field :emoji, :string
    field :name, :string
    belongs_to :owner, Piccadilly.Accounts.User
    many_to_many :users, Piccadilly.Accounts.User, join_through: Piccadilly.Timeline.GroupUser
    many_to_many :posts, Piccadilly.Timeline.Post, join_through: Piccadilly.Timeline.GroupPost

    timestamps()
  end

  @doc false
  def changeset(group, attrs \\ %{}) do
    group
    |> cast(attrs, [:name, :description, :emoji, :owner_id])
    |> validate_required([:name, :description, :emoji])
    |> assoc_constraint(:owner)
    |> unique_constraint(:unique_users, name: :groups_users_index)
    |> unique_constraint(:unique_posts, name: :groups_posts_index)
  end
end
