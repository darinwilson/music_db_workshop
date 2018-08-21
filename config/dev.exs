use Mix.Config

{whoami, _} = System.cmd("whoami", [])
whoami = String.replace(whoami, "\n", "")

config :music_db, MusicDB.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "music_db_workshop_dev",
  username: System.get_env("DATABASE_USERNAME") || whoami,
  password: System.get_env("DATABASE_PASSWORD") || nil,
  hostname: "localhost"

