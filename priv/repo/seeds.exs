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

username =
  ?a..?z
  |> Enum.take_random(10)
  |> List.to_string()

user =
  %User{email: "#{username}@whitehouse.gov"}
  |> User.registration_changeset(%{password: "sekretsauceseriously42", hashed_password: "x"})
  |> Repo.insert!()

group =
  %Group{owner: user, name: "🦹", emoji: "🧚‍♀️", description: "🙇‍♀️"}
  |> Group.changeset()
  |> Repo.insert!()

post =
  %Post{user: user, image_url: "Meow", likes_count: 5}
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
