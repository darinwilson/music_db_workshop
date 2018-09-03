defmodule AssociationExercisesTest do
  use MusicDB.DBCase
  import Ecto.Query
  alias MusicDB.Exercises.AssociationExercises
  alias MusicDB.{Repo, Album, Release}

  @tag :skip
  test "create a has_many association between albums and releases" do
    {:ok, album} = Repo.insert(%Album{title: "Dark Side Of The Moon"})
    assert %Release{} = Ecto.build_assoc(album, :releases)
  end

  @tag :skip
  test "insert album and release" do
    AssociationExercises.insert_album_and_release
    album = Repo.get_by(Album, title: "Giant Steps")
    release = Repo.get_by(Release, title: "Giant Steps (remastered)")
    assert release.album_id == album.id
  end

  @tag :skip
  test "fetching an album and its preloaded releases" do
    AssociationExercises.insert_album_and_release
    album = AssociationExercises.fetch_album_with_releases
    assert album.title == "Giant Steps"
    releases = album.releases
    assert Enum.count(releases) == 1
    assert Enum.map(releases, &(&1.title)) == ["Giant Steps (remastered)"]
  end

  @tag :skip
  test "delete an album and its associated release" do
    AssociationExercises.insert_album_and_release
    album = Repo.get_by(Album, title: "Giant Steps")
    AssociationExercises.delete_album_and_release(album)
    assert Repo.get_by(Album, title: "Giant Steps") == nil
    assert Repo.get_by(Release, title: "Giant Steps (remastered)") == nil
  end
end

