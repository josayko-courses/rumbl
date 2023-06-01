defmodule RumblWeb.UserController do
  use RumblWeb, :controller

  alias Rumbl.Accounts
  alias Rumbl.Accounts.User

  plug :authenticate_user when action in [:index, :show]

  def new(conn, _) do
    changeset = Accounts.change_registration(%User{}, %{})
    render(conn, :new, changeset: changeset)
  end

  def index(conn, _) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    render(conn, :show, user: user)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> RumblWeb.Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: ~p"/users")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
