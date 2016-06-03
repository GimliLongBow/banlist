defmodule Banlist.UserTest do
  use Banlist.ModelCase

  alias Banlist.User

  @valid_attrs %{email: "someone@none.com", name: "Bob Test", password: "RandomPassedWord"}
  @invalid_attrs %{email: "aninvalidemail"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with an existing email" do
    changeset = User.changeset(%User{}, @valid_attrs)
    {:ok, result} = Repo.insert(changeset)

    changeset_with_dup_email = User.changeset(%User{}, @valid_attrs)
    refute changeset_with_dup_email.valid?
  end
end
