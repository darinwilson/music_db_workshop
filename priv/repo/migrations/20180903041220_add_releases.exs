defmodule MusicDB.Repo.Migrations.AddReleases do
  use Ecto.Migration

  def change do
    create table(:releases) do
      add :title, :string, null: false
      add :release_date, :date, null: true
      add :album_id, references(:albums, on_delete: :delete_all)
      timestamps()
    end

    create index(:releases, :album_id)
  end
end
