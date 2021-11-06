defmodule BooksCat.Storage.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "books" do
    field :authors, {:array, :string}
    field :category, {:array, :string}
    field :cover, :string
    field :description, :string
    field :isbn, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :isbn, :description, :authors, :category, :cover])
    |> validate_required([:title, :isbn, :description, :authors, :category, :cover])
    |> unique_constraint(:isbn)
  end
end
