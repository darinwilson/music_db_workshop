defmodule MusicDB.DBCase do
  use ExUnit.CaseTemplate

  alias MusicDB.Repo

  using do
    quote do
      alias MusicDB.Repo
      import Ecto
      import Ecto.Query, only: [from: 2]
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(MusicDB.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(MusicDB.Repo, {:shared, self()})
    end

    :ok
  end

end
