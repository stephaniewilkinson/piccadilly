defmodule PiccadillyWeb.PostLive.Index do
  use PiccadillyWeb, :live_view

  alias Piccadilly.Accounts
  alias Piccadilly.Repo
  alias Piccadilly.Accounts.User
  alias Piccadilly.Timeline
  alias Piccadilly.Timeline.Post

  @impl true
  def mount(_params, session, socket) do
    socket = assign_user(session, socket)

    case socket.assigns.user do
      %User{} ->
        {:ok, assign(socket, :posts, list_posts(socket.assigns.user.id))}

      _not_logged_in ->
        {:ok,
         assign(socket, :posts, [])
         |> put_flash(:error, "Please log in.")
        #  |> redirect(to: Routes.user_registration_path(socket, :new))
        }
    end
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Post")
    |> assign(:post, Timeline.get_post!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:post, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Timeline.get_post!(id)
    {:ok, _} = Timeline.delete_post(post)

    {:noreply, assign(socket, :posts, list_posts(socket.assigns.user.id))}
  end

  defp list_posts(user_id) do
    Accounts.get_user!(user_id)
    |> Repo.preload(:groups)
    |> Timeline.list_posts()
  end
end
