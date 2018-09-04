defmodule QueryExercisesTest do
  use MusicDB.DBCase
  import Ecto.Query

  alias MusicDB.{
    Exercises.QueryExercises,
    Artist,
    Track,
    Album
  }

  @tag :skip
  test "fetch the artist with the id of 1" do
    Repo.insert!(%Artist{name: "Taylor Swift"})

    [artist] = QueryExercises.simplest_query()
    assert artist.name == "Taylor Swift"
  end

  @tag :skip
  test "return the raw sql for a query that selects all artist names" do
    sql = QueryExercises.inspect_sql()
    assert sql == {"SELECT a0.\"birth_date\" FROM \"artists\" AS a0", []}
  end

  @tag :skip
  test "find an artist by name" do
    Repo.insert!(%Artist{name: "Taylor Swift"})
    Repo.insert!(%Artist{name: "Bill Evans"})

    [artist] = QueryExercises.find_artist_by_name("Bill Evans")
    assert artist.name == "Bill Evans"
  end

  @tag :skip
  test "fetch tracks with names that include 'Theme'" do
    Repo.insert!(%Track{title: "Theme Song", index: 1})
    Repo.insert!(%Track{title: "Main Theme", index: 2})
    Repo.insert!(%Track{title: "Should not be found", index: 3})

    tracks = QueryExercises.search_tracks("%Theme%")
    assert Enum.count(tracks) == 2

    Enum.each(tracks, fn track ->
      assert track.title =~ "Theme"
    end)
  end

  @tag :skip
  test "search albums by their tracks" do
    album_1 = Repo.insert!(%Album{title: "Supernova"})
    album_2 = Repo.insert!(%Album{title: "Skygate"})
    album_3 = Repo.insert!(%Album{title: "Binary"})

    Repo.insert!(%Track{title: "Theme Song", index: 1, album_id: album_1.id})
    Repo.insert!(%Track{title: "Main Theme", index: 2, album_id: album_1.id})

    Repo.insert!(%Track{title: "Song Song", index: 1, album_id: album_2.id})

    Repo.insert!(%Track{title: "Should not find", index: 2, album_id: album_3.id})

    albums = QueryExercises.search_albums_by_track("%Song%")
    assert Enum.count(albums) == 2
  end

  @tag :skip
  test "finds track by title and updates that title to 'Rolling in the Deep'" do
    Repo.insert!(%Track{title: "Flamenco Sketches", index: 1})

    QueryExercises.find_and_update_track!("Flamenco Sketches")

    assert Repo.get_by(Track, title: "Rolling in the Deep")
  end

  @tag :skip
  test "finds track by title and deletes it" do
    Repo.insert!(%Track{title: "Flamenco Sketches", index: 1})
    assert Repo.get_by(Track, title: "Flamenco Sketches")

    QueryExercises.find_and_delete_track!("Flamenco Sketches")
    refute Repo.get_by(Track, title: "Flamenco Sketches")
  end

  @tag :skip
  test "orders artists by name desc" do
    artists =
      for n <- 1..9 do
        Repo.insert!(%Artist{name: "#{n}"})
      end

    artist_names = Enum.map(artists, & &1.name)

    ordered_artist_names =
      QueryExercises.order_artists_by_name()
      |> List.flatten()

    assert Enum.reverse(artist_names) == ordered_artist_names
  end

  @tag :skip
  test "finding an album's duration using group_by" do
    album = Repo.insert!(%Album{title: "Heartbeat"})

    for n <- 1..10 do
      Repo.insert!(%Track{title: "Theme #{n}", duration: n * 10, album_id: album.id, index: n})
    end

    result = QueryExercises.group_album_duration()

    assert result == [[album.id, 550]]
  end
end
