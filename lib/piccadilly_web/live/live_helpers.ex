defmodule PiccadillyWeb.LiveHelpers do
  import Phoenix.LiveView, only: [assign_new: 3]
  import Phoenix.LiveView.Helpers

  def assign_user(session, socket) do
    assign_new(socket, :user, user_fn(session))
  end

  defp user_fn(session) do
    fn ->
      session["user_token"]
      |> get_user_by_session_token()
    end
  end

  defp get_user_by_session_token(nil), do: nil

  defp get_user_by_session_token(user_token) do
    Piccadilly.Accounts.get_user_by_session_token(user_token)
  end

  @doc """
  Renders a component inside the `PiccadillyWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, PiccadillyWeb.PostLive.FormComponent,
        id: @post.id || :new,
        action: @live_action,
        post: @post,
        return_to: Routes.post_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, PiccadillyWeb.ModalComponent, modal_opts)
  end
end
