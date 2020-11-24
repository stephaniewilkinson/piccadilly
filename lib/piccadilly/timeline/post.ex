defmodule Piccadilly.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :caption, :string
    field :image_url, :string
    field :likes_count, :integer
    field :username, :string
    belongs_to :user, Piccadilly.Accounts.User
    many_to_many :groups, Piccadilly.Timeline.Group, join_through: "groups_posts", join_keys: [group_id: :id, post_id: :id]

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:username, :caption, :image_url, :likes_count])
    |> validate_required([:username, :caption, :image_url, :likes_count])
    |> put_assoc(:groups, attrs[:groups])
  end
end
