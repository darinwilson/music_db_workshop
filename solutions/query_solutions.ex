defmodule MusicDB.Exercises.QueryExercises do
  import Ecto.Query

  alias MusicDB.Repo

  def simplest_query do
    # use Ecto.Query.from to define a query that selects all artists.
    # Then use Repo.all to fetch the record with that query.

    query = from(a in "artists", select: [:id, :name])
    Repo.all(query)
  end

  def inspect_sql do
    # Define a query that selects all the artist birth_dates. Then use
    # Ecto.Adapters.SQL.to_sql(:all, Repo, query) to inspect the raw sql.

    query = from(a in "artists", select: [:birth_date])
    Ecto.Adapters.SQL.to_sql(:all, Repo, query)
  end

  def find_artist_by_name(name) do
    # Define a query that finds an artist by the name passed to this function.

    query = from(a in "artists", where: a.name == ^name, select: [:id, :name])
    Repo.all(query)
  end

  def search_tracks(query) do
    # Define a query that finds tracks with a title like the title passed in.
    # This function should leverage sql's like functionality.

    query = from(t in "tracks", where: like(t.title, ^"%#{query}%"), select: [:id, :title])
    Repo.all(query)
  end

  def search_albums_by_track(track_title) do
    # Define a query that fetches all the albums and includes their tracks
    # in a join. Then search the tracks by title like the query above.
    query =
      from(a in "albums",
        join: t in "tracks",
        on: t.album_id == a.id,
        where: like(t.title, ^track_title),
        select: [a.id, a.title]
      )

    Repo.all(query)
  end

  def find_and_update_track!(title) do
    # Find a track by title and use Repo.update_all to set the title to "Rolling in the Deep"
    query = from(t in "tracks", where: t.title == ^title)

    Repo.update_all(query, set: [title: "Rolling in the Deep"])
  end

  def find_and_delete_track!(title) do
    # Find a track by title and delete it.
    query = from(t in "tracks", where: t.title == ^title)

    Repo.delete_all(query)
  end

  def order_artists_by_name do
    # Select all artists and use `order_by:` to order them by name desc.

    query = from(a in "artists", select: [a.name], order_by: [desc: a.name])

    Repo.all(query)
  end

  def group_album_duration do
    # Query tracks and select the album_id and use sum to calculate the duration, then
    # group by album_id.

    query = from(t in "tracks", select: [t.album_id, sum(t.duration)], group_by: t.album_id)

    Repo.all(query)
  end
end
