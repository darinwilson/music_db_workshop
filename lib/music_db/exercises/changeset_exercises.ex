defmodule MusicDB.Exercises.ChangesetExercises do
  import Ecto.Changeset

  alias MusicDB.{
    Repo,
    Artist
  }

  def create_changeset_for_artist(artist) do
    # use Ecto.Changeset.change to create a changeset updating the artist's name
    # to Josh Groban.
    change(artist, %{name: "Josh Groban"})
  end

  def create_changeset_for_external_data(artist, params) do
    # the params hash is user provided information, which means it should be treated
    # with care :). Use Ecto.Changeset.cast to cast only the parameters you want
    # into the Artist struct. These params should be name & birth_date.

    cast(artist, params, [:name, :birth_date])
  end
end
