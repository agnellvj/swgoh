defmodule App.Repo.Migrations.CreateCharacters do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string
      add :data, :map

      timestamps()
    end

  end
end
