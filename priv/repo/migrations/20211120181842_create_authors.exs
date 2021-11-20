defmodule BooksCat.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :full_name, :string

      timestamps()
    end

    create unique_index(:authors, [:full_name])
  end
end
