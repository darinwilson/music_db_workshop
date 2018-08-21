defmodule MusicDBTest do
  use MusicDB.DBCase
  alias MusicDB.{Repo, Artist}

  @moduletag :setup_test

  test "verifies that app is correctly configured" do
    {2, _return} =
      Repo.insert_all("artists", [[name: "John Coltrane"], [name: "Esperanza Spalding"]])

    assert Repo.aggregate("artists", :count, :id) == 2
    assert %Artist{} = Repo.get_by(Artist, name: "John Coltrane")
    assert %Artist{} = Repo.get_by(Artist, name: "Esperanza Spalding")
  end
end
