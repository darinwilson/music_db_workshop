defmodule ChangesetExercisesTest do
  use MusicDB.DBCase

  alias MusicDB.{
    Exercises.ChangesetExercises,
    Artist
  }

  test "create simple changeset chaning artist's name to Josh Groban" do
    artist = Repo.insert!(%Artist{name: "Taylor Swift"})
    changeset = ChangesetExercises.create_changeset_for_artist(artist)
    assert changeset.changes == %{name: "Josh Groban"}
  end

  test "use cast to select only the params you want from the user's input" do
    params = %{
      "admin" => true,
      "birth_date" => "1920-08-29",
      "name" => "John Smith"
    }

    changeset = ChangesetExercises.create_changeset_for_external_data(%Artist{}, params)

    assert changeset.changes == %{name: "John Smith", birth_date: ~D[1920-08-29]}
  end
end
