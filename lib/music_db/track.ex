defmodule MusicDB.Track do
  use Ecto.Schema
  alias MusicDB.Album

  schema "tracks" do
    field(:title, :string)
    field(:duration, :integer)
    field(:duration_string, :string, virtual: true)
    field(:index, :integer)
    field(:number_of_plays, :integer)
    timestamps()

    belongs_to(:album, Album)

  end
end
