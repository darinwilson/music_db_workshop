defmodule MusicDB.Repo.Migrations.AddArtistsTable do
  use Ecto.Migration

  def change do
    create table(:artists) do
      add :name, :string, null: false
      add :birth_date, :date, null: true
      add :death_date, :date, null: true

      # normally you would not make this nullable - we did this here
      # just to simplify some examples
      timestamps null: true
    end

    create index(:artists, :name)
  end
end
