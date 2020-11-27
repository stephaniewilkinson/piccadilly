# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Piccadilly.Repo.insert!(%Piccadilly.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Piccadilly.{Repo, Accounts.User}
alias Piccadilly.Timeline.{Group, Post}

email = "obama@whitehouse.gov"
password = "sexymichelle"

user =
  %User{email: email}
  |> User.registration_changeset(%{password: password})
  |> Repo.insert!()

group =
  %Group{owner: user, name: "🦹", emoji: "🧚‍♀️", description: "🙇‍♀️"}
  |> Group.changeset()
  |> Repo.insert!()

post =
  %Post{user: user, image_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Michelle_Obama_2013_official_portrait.jpg/1280px-Michelle_Obama_2013_official_portrait.jpg", likes_count: 420}
  |> Post.changeset()
  |> Repo.insert!()

user
|> Repo.preload(:groups)
|> User.changeset_add_group(group)
|> Repo.update!()

post
|> Repo.preload(:groups)
|> Post.changeset_add_group(group)
|> Repo.update!()
