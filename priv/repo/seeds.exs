# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Banlist.Repo.insert!(%Banlist.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Banlist.Repo
alias Banlist.User

# Empty the database.
query = "TRUNCATE banned, users RESTART IDENTITY;"
Ecto.Adapters.SQL.query!(Repo, query, [])

admin = %{
  name: "Admin User",
  email: "admin@substratalcode.com",
  password: "password"
}

test = %{
  name: "Test User",
  email: "test@substratalcode.com",
  password: "password"
}

%Banlist.User{}
|> User.password_changeset(admin)
|> Repo.insert!

%Banlist.User{}
|> User.password_changeset(test)
|> Repo.insert!
