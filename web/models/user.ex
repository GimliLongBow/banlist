defmodule Banlist.User do
  use Banlist.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hashed, :string
    field :password, :string, virtual: true

    timestamps
  end

  @required_fields ~w(name email password)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_confirmation(:password)
  end

  @doc """
  Creates a changeset with a password.
  """
  def password_changeset(model, params \\ %{}) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> create_password_hash
  end

  def create_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hashed, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
