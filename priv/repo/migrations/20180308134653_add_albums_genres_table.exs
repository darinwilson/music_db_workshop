defmodule MusicDB.Repo.Migrations.AddAlbumsGenresTable do
  use Ecto.Migration

  def change do
    create table(:albums_genres) do
      add :album_id, references(:albums)
      add :genre_id, references(:genres)
    end

    create index(:albums_genres, :album_id)
    create index(:albums_genres, :genre_id)
  end
end
