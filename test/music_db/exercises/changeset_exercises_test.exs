defmodule ChangesetExercisesTest do
  use MusicDB.DBCase
  alias MusicDB.Exercises.ChangesetExercises
  alias MusicDB.{Artist, Album, Track}

  test "create a changeset from an Artist struct" do
    changeset = ChangesetExercises.create_changeset_from_artist(%Artist{})
    assert changeset.changes == %{name: "Sarah Vaughan"}
  end

  test "create a changeset from a map" do
    params = %{name: "Bobby Hutcherson", birth_date: "1941-01-27", instrument: "vibraphone"}
    changeset = ChangesetExercises.create_changeset_from_map(params)
    assert changeset.data == %Artist{}
    assert changeset.changes == %{name: "Bobby Hutcherson", birth_date: ~D[1941-01-27]}
  end

  test "create changeset for Track" do
    valid_params = %{title: "Walkin'", duration: 896}
    changeset = ChangesetExercises.changeset_for_track(%Track{}, valid_params)
    assert changeset.data == %Track{}
    assert changeset.valid?
    assert changeset.changes == valid_params

    invalid_params = %{title: "Walkin'"}
    changeset = ChangesetExercises.changeset_for_track(%Track{}, invalid_params)
    assert changeset.valid? == false
    assert changeset.changes == invalid_params
    assert Keyword.keys(changeset.errors) == [:duration]

    invalid_params2 = %{title: "Walkin'", duration: 0}
    changeset = ChangesetExercises.changeset_for_track(%Track{}, invalid_params2)
    assert changeset.valid? == false
    assert changeset.changes == invalid_params2
    assert Keyword.keys(changeset.errors) == [:duration]
  end

  test "create a child record with build_assoc" do
    artist = Repo.insert!(%Artist{name: "Esperanza Spalding"})
    album = ChangesetExercises.create_album_for_artist(artist, "Jujo")
    assert %Album{} = album
    assert album.artist_id == artist.id
    assert album.title == "Jujo"
    assert {:ok, _album} = Repo.insert(album)
  end

  test "create child records with put_assoc" do
    artist = Repo.insert!(%Artist{name: "Gene Harris"})
    album1 = %Album{title: "Like A Lover"}
    album2 = %Album{title: "In His Hands"}
    changeset = ChangesetExercises.create_child_records_with_put_assoc(artist, [album1, album2])
    assert changeset.valid?
    assert {:ok, artist} = Repo.update(changeset)
    artist = Repo.preload(artist, :albums)
    assert Enum.count(artist.albums) == 2
    titles = Enum.map(artist.albums, &(Map.get(&1, :title)))
    assert Enum.member?(titles, "Like A Lover")
    assert Enum.member?(titles, "In His Hands")
  end

  test "create child records with cast_assoc" do
    artist = Repo.insert!(%Artist{name: "Gene Harris"})
    albums = [%{"title" => "Like A Lover"}, %{"title" => "In His Hands"}]
    changeset = ChangesetExercises.create_child_records_with_cast_assoc(artist, albums)
    assert changeset.valid?
    assert {:ok, artist} = Repo.update(changeset)
    artist = Repo.preload(artist, :albums)
    assert Enum.count(artist.albums) == 2
    titles = Enum.map(artist.albums, &(Map.get(&1, :title)))
    assert Enum.member?(titles, "Like A Lover")
    assert Enum.member?(titles, "In His Hands")
  end

end
