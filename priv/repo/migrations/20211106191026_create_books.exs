defmodule BooksCat.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :isbn, :text
      add :description, :text
      add :authors, {:array, :string}
      add :category, {:array, :string}
      add :cover, :text

      timestamps()
    end

    create unique_index(:books, [:isbn])
  end
end
