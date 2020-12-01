defmodule Piccadilly.TimelineTest do
  use Piccadilly.DataCase

  import Piccadilly.AccountsFixtures

  alias Piccadilly.Timeline

  describe "posts" do
    alias Piccadilly.Timeline.Post

    @valid_attrs %{caption: "some caption", image_url: "some image_url", likes_count: 42}
    @update_attrs %{caption: "some updated caption", image_url: "some updated image_url", likes_count: 43}
    @invalid_attrs %{caption: nil, image_url: nil, likes_count: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Timeline.create_post()

      post
    end

    test "list_posts/1 returns no posts when user not logged in" do
      post_fixture()
      user = user_fixture(%{email: "dirtyfrank@hotmail.com", password: "asdfjkl;1234"})

      assert Timeline.list_posts(user) == []
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Timeline.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Timeline.create_post(@valid_attrs)
      assert post.caption == "some caption"
      assert post.image_url == "some image_url"
      assert post.likes_count == 42
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timeline.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Timeline.update_post(post, @update_attrs)
      assert post.caption == "some updated caption"
      assert post.image_url == "some updated image_url"
      assert post.likes_count == 43
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeline.update_post(post, @invalid_attrs)
      assert post == Timeline.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Timeline.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Timeline.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Timeline.change_post(post)
    end
  end

  describe "groups" do
    alias Piccadilly.Timeline.Group

    @valid_attrs %{description: "some description", emoji: "⛵️", name: "some name"}
    @update_attrs %{description: "some updated description", emoji: "🔥", name: "some updated name"}
    @invalid_attrs %{description: nil, emoji: nil, name: nil}

    def group_fixture(attrs \\ %{}) do
      {:ok, group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Timeline.create_group()

      group
    end

    test "list_groups/0 returns all groups" do
      group = group_fixture()
      assert Enum.member?(Timeline.list_groups(), group)
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Timeline.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      assert {:ok, %Group{} = group} = Timeline.create_group(@valid_attrs)
      assert group.description == "some description"
      assert group.emoji == "⛵️"
      assert group.name == "some name"
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timeline.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      assert {:ok, %Group{} = group} = Timeline.update_group(group, @update_attrs)
      assert group.description == "some updated description"
      assert group.emoji == "🔥"
      assert group.name == "some updated name"
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeline.update_group(group, @invalid_attrs)
      assert group == Timeline.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Timeline.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Timeline.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Timeline.change_group(group)
    end
  end
end
