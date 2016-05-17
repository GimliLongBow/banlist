defmodule Banlist.BannedTest do
  use Banlist.ModelCase

  alias Banlist.Banned

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Banned.changeset(%Banned{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Banned.changeset(%Banned{}, @invalid_attrs)
    refute changeset.valid?
  end
end
