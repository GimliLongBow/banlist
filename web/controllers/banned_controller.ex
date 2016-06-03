defmodule Banlist.BannedController do
  use Banlist.Web, :controller

  alias Banlist.Banned

  plug :scrub_params, "banned" when action in [:create, :update]
  plug :authenticate

  def index(conn, _params) do
    banned = Repo.all(Banned)
    render(conn, "index.html", banned: banned)
  end

  def new(conn, _params) do
    changeset = Banned.changeset(%Banned{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"banned" => banned_params}) do
    changeset = Banned.changeset(%Banned{}, banned_params)

    case Repo.insert(changeset) do
      {:ok, _banned} ->
        conn
        |> put_flash(:info, "Banned created successfully.")
        |> redirect(to: banned_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    banned = Repo.get!(Banned, id)
    render(conn, "show.html", banned: banned)
  end

  def edit(conn, %{"id" => id}) do
    banned = Repo.get!(Banned, id)
    changeset = Banned.changeset(banned)
    render(conn, "edit.html", banned: banned, changeset: changeset)
  end

  def update(conn, %{"id" => id, "banned" => banned_params}) do
    banned = Repo.get!(Banned, id)
    changeset = Banned.changeset(banned, banned_params)

    case Repo.update(changeset) do
      {:ok, banned} ->
        conn
        |> put_flash(:info, "Banned updated successfully.")
        |> redirect(to: banned_path(conn, :show, banned))
      {:error, changeset} ->
        render(conn, "edit.html", banned: banned, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    banned = Repo.get!(Banned, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(banned)

    conn
    |> put_flash(:info, "Banned deleted successfully.")
    |> redirect(to: banned_path(conn, :index))
  end

  def authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access this page")
      |> redirect(to: session_path(conn, :new))
      |> halt()
    end
  end
end
