defmodule Banlist.TestHelpers do
  alias Banlist.Repo

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      name: "Some User",
      email: "testing@substratalcode.com",
      password: "supersecret"
    }, attrs)

    %Banlist.User{}
    |> Banlist.User.password_changeset(changes)
    |> Repo.insert!
  end
end
