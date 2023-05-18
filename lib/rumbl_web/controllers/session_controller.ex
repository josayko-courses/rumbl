defmodule RumblWeb.SessionController do
  use RumblWeb, :controller

  def new(conn, _) do
    render(conn, :new)
  end

  def create(conn, %{"session" => %{"username" => username, "password" => pass}}) do
    case Rumbl.Accounts.authenticate_by_username_and_pass(username, pass) do
      {:ok, user} ->
        conn
        |> RumblWeb.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: ~p"/users")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render(:new)
    end
  end

  def delete(conn, _) do
    conn
    |> RumblWeb.Auth.logout()
    |> redirect(to: ~p"/")
  end
end
