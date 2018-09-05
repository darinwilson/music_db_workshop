defmodule SchemaExercisesTest do
  use MusicDB.DBCase

  alias MusicDB.{
    Album,
    Artist,
    Exercises.SchemaExercises,
    Repo,
    Track
  }

  test "convert schema-less query" do
    artists =
      for n <- 1..5 do
        Repo.insert!(%Artist{name: "n", birth_date: Ecto.Date.cast!("1990-11-1#{n}")})
      end

    [artist] = SchemaExercises.convert_schema_less_query()

    assert artist.name == List.last(artists).name
  end

  test "insert a track record" do
    assert Repo.aggregate(Track, :count, :id) == 0

    SchemaExercises.insert_a_track!()

    assert Repo.aggregate(Track, :count, :id) == 1
  end

  test "deletes album" do
    album = Repo.insert!(%Album{title: "Wildfire"})
    assert Repo.get_by(Album, title: "Wildfire")

    SchemaExercises.delete_an_album!(album)

    refute Repo.get_by(Album, title: "Wildfire")
  end
end
