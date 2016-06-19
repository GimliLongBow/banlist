defmodule Banlist.UserTest do
  use Banlist.ModelCase

  alias Banlist.User
  alias Banlist.Repo

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
    User.changeset(%User{}, @valid_attrs)
    |> Repo.insert!

    {:error, changeset} = User.changeset(%User{}, @valid_attrs)
    |> Repo.insert

    refute changeset.valid?
  end
end
