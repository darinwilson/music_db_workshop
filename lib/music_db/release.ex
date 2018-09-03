defmodule MusicDB.Release do
  use Ecto.Schema
  import Ecto.Changeset
  alias MusicDB.Album

  # create the schema for releases table here - it should have the following fields:
  #   title (string)
  #   release_date (date)
  #   timestamps
  # and have a belongs_to association with albums - you'll also need to add a has_many
  # association between albums and releases
  schema "releases" do

  end

end
