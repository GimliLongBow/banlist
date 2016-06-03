defmodule Banlist.Auth do
  import Plug.Conn

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user    = user_id && repo.get(Banlist.User, user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def login_by_email_and_password(conn, email, password, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Banlist.User, email: email)

    cond do
      user && Comeonin.Bcrypt.checkpw(password, user.password_hashed) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorizzed, conn}
      true ->
        Comeonin. dummy_checkpw()
        {:error, :not_found, conn}
    end
  end
end
