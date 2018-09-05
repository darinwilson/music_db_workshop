defmodule MusicDB.Repo do
  use Ecto.Repo, otp_app: :music_db

  def max_id(table_name) do
    aggregate(table_name, :max, :id)
  end

  def count(table_name) do
    # Add the code needed to return the number of records in the given table
    # Hint: the Ecto.Repo.aggregate function can be used to return record counts - see
    # the max_id function above for an example, and check out the docs for the aggregate
    # function to see what to use instead of :max
    # https://hexdocs.pm/ecto/Ecto.Repo.html#c:aggregate/4

  end

end
