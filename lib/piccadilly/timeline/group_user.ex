defmodule Piccadilly.Timeline.GroupUser do
  use Ecto.Schema

  schema "groups_users" do
    belongs_to :group, Piccadilly.Timeline.Group
    belongs_to :user, Piccadilly.Accounts.User

    timestamps(updated_at: false)
  end
end
