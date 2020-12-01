defmodule Piccadilly.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :caption, :string
    field :image_url, :string
    field :likes_count, :integer
    belongs_to :user, Piccadilly.Accounts.User
    many_to_many :groups, Piccadilly.Timeline.Group, join_through: Piccadilly.Timeline.GroupPost

    timestamps()
  end

  def changeset(post, attrs \\ %{}) do
    post
    |> cast(attrs, [:caption, :image_url, :likes_count])
    |> validate_required([:image_url, :likes_count])
  end

  def changeset_add_group(post, group, attrs \\ %{}) do
    post
    |> cast(attrs, [:caption, :image_url, :likes_count])
    |> put_assoc(:groups, [group | post_groups(post)])
  end

  defp post_groups(post) do
    post
    |> Piccadilly.Repo.preload(:groups)
    |> Map.get(:groups)
  end
end
