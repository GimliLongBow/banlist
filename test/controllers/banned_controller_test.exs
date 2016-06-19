defmodule Banlist.BannedControllerTest do
  use Banlist.ConnCase

  alias Banlist.Banned
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    user = insert_user
    conn = assign(conn(), :current_user, user)
    {:ok, conn: conn, user: user}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, banned_path(conn, :index)
    assert html_response(conn, 200) =~ "Banned Names"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, banned_path(conn, :new)
    assert html_response(conn, 200) =~ "Add name"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, banned_path(conn, :create), banned: @valid_attrs
    assert redirected_to(conn) == banned_path(conn, :index)
    assert Repo.get_by(Banned, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, banned_path(conn, :create), banned: @invalid_attrs
    assert html_response(conn, 200) =~ "Add name"
  end

  test "shows chosen resource", %{conn: conn} do
    banned = Repo.insert! %Banned{}
    conn = get conn, banned_path(conn, :show, banned)
    assert html_response(conn, 200) =~ "Show banned"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, banned_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    banned = Repo.insert! %Banned{}
    conn = get conn, banned_path(conn, :edit, banned)
    assert html_response(conn, 200) =~ "Edit banned"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    banned = Repo.insert! %Banned{}
    conn = put conn, banned_path(conn, :update, banned), banned: @valid_attrs
    assert redirected_to(conn) == banned_path(conn, :show, banned)
    assert Repo.get_by(Banned, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    banned = Repo.insert! %Banned{}
    conn = put conn, banned_path(conn, :update, banned), banned: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit banned"
  end

  test "deletes chosen resource", %{conn: conn} do
    banned = Repo.insert! %Banned{}
    conn = delete conn, banned_path(conn, :delete, banned)
    assert redirected_to(conn) == banned_path(conn, :index)
    refute Repo.get(Banned, banned.id)
  end
end
