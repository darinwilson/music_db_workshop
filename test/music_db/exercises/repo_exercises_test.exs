defmodule RepoExercisesTest do
  use MusicDB.DBCase
  import Ecto.Query
  alias MusicDB.Exercises.RepoExercises

  @tag :skip
  test "insert a single record with insert_all" do
    RepoExercises.insert_a_single_record()
    assert find_artist("Jimi Hendrix") == [%{name: "Jimi Hendrix"}]
  end

  @tag :skip
  test "insert multiple records with insert_all" do
    RepoExercises.insert_multiple_records()
    assert find_artist("Charlie Parker") == [%{name: "Charlie Parker"}]
    assert find_artist("Dizzie Gillespie") == [%{name: "Dizzie Gillespie"}]
  end

  @tag :skip
  test "delete records with delete_all" do
    RepoExercises.insert_multiple_records()
    RepoExercises.delete_all_artists()
    assert Repo.all(from("artists", select: [:id])) == []
  end

  @tag :skip
  test "add a custom function to MusicDB.Repo that counts records in a table" do
    RepoExercises.insert_multiple_records()
    assert Repo.count("artists") == 2
  end

  @tag :skip
  ### BONUS TEST (only works with Postgres)
  test "insert a single record and customize the return the id" do
    result = RepoExercises.insert_a_single_record_and_return_the_id()
    assert {1, [%{id: _id}]} = result
  end

  def find_artist(name) do
    Repo.all(from("artists", where: [name: ^name], select: [:name]))
  end
end
