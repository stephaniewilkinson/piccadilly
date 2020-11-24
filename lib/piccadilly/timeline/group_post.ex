defmodule Piccadilly.Timeline.GroupPost do
  use Ecto.Schema

  schema "groups_posts" do
    belongs_to :group, Piccadilly.Timeline.Group
    belongs_to :post, Piccadilly.Timeline.Post

    timestamps(updated_at: false)
  end
end
