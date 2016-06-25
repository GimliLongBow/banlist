defmodule Banlist.UserControllerTest do
  use Banlist.ConnCase
  require Logger

  alias Banlist.User
  @valid_attrs %{
    name: "Bob",
    email: "user-testing@substratalcode.com",
    password: "aoinfaiunfai",
    password_confirmation: "aoinfaiunfai",
  }
  @invalid_attrs %{}

  setup do
    user = insert_user
    conn = assign(build_conn(), :current_user, user)
    {:ok, conn: conn, user: user}
  end

  test "requires user authentication on all actions" do
    conn = build_conn()
    Enum.each([
      get(conn, user_path(conn, :new)),
      get(conn, user_path(conn, :index)),
      get(conn, user_path(conn, :show, "123")),
      get(conn, user_path(conn, :edit, "123")),
      get(conn, user_path(conn, :update, "123", %{})),
      get(conn, user_path(conn, :create, %{})),
      get(conn, user_path(conn, :delete, "123")),
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert html_response(conn, 200) =~ "Users"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "New user"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    # Logger.debug conn.changeset
    assert redirected_to(conn) == user_path(conn, :index)
    assert Repo.get_by(User, email: @valid_attrs.email)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200) =~ "New user"
  end

  test "shows chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = get conn, user_path(conn, :show, user)
    assert html_response(conn, 200) =~ "Show user"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = get conn, user_path(conn, :edit, user)
    assert html_response(conn, 200) =~ "Edit user"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = put conn, user_path(conn, :update, user), user: @valid_attrs
    assert redirected_to(conn) == user_path(conn, :show, user)
    assert Repo.get_by(User, email: @valid_attrs.email)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit user"
  end

  test "deletes chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = delete conn, user_path(conn, :delete, user)
    assert redirected_to(conn) == user_path(conn, :index)
    refute Repo.get(User, user.id)
  end
end
