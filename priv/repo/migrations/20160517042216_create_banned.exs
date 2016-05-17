defmodule Banlist.Repo.Migrations.CreateBanned do
  use Ecto.Migration

  def change do
    create table(:banned) do
      add :name, :string

      timestamps
    end

  end
end
