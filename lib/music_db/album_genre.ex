defmodule MusicDB.AlbumGenre do
  use Ecto.Schema
  alias MusicDB.{Album, Genre}

  schema "albums_genres" do
    belongs_to(:albums, Album)
    belongs_to(:genres, Genre)
  end
end
