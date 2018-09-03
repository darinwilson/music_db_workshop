defmodule MusicDB.Album do
  use Ecto.Schema
  import Ecto.Changeset
  alias MusicDB.{Artist, Track, Genre, Release}

  schema "albums" do
    field(:title, :string)
    timestamps()

    belongs_to(:artist, Artist)
    has_many(:tracks, Track)
    many_to_many(:genres, Genre, join_through: "albums_genres")

  end

  def changeset(album, params) do
    album
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
