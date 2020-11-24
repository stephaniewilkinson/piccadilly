defmodule Piccadilly.Timeline.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :description, :string
    field :emoji, :string
    field :name, :string
    belongs_to :owner, Piccadilly.Accounts.User
    many_to_many :users, Piccadilly.Accounts.User, join_through: "groups_users", join_keys: [group_id: :id, user_id: :id]
    many_to_many :posts, Piccadilly.Timeline.Post, join_through: "groups_posts", join_keys: [group_id: :id, post_id: :id]

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :description, :emoji])
    |> validate_required([:name, :description, :emoji])
    |> put_assoc(:posts, attrs[:posts])
    |> put_assoc(:users, attrs[:users])
    |> unique_constraint(:unique_users, name: :groups_users_index)
    |> unique_constraint(:unique_posts, name: :groups_posts_index)
  end
end
