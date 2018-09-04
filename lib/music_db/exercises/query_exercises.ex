defmodule MusicDB.Exercises.QueryExercises do
  import Ecto.Query

  alias MusicDB.Repo

  def simplest_query do
    # use Ecto.Query.from to define a query that selects all artists.
    # Then use Repo.all to fetch the record with that query.
  end

  def inspect_sql do
    # Define a query that selects all the artist birth_dates. Then use
    # Ecto.Adapters.SQL.to_sql(:all, Repo, query) to inspect the raw sql.
  end

  def find_artist_by_name(name) do
    # Define a query that finds an artist by the name passed to this function.
  end

  def search_tracks(title) do
    # Define a query that finds tracks with a title like the title passed in.
    # This function should leverage sql's like functionality.
  end

  def search_albums_by_track(track_title) do
    # Define a query that fetches all the albums and includes their tracks
    # in a join. Then search the tracks by title like the query above.
  end

  def find_and_update_track!(title) do
    # Find a track by title and use Repo.update_all to set the title to "Rolling in the Deep"
  end

  def find_and_delete_track!(title) do
    # Find a track by title and delete it using Repo.delete_all.
  end
end
