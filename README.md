# MusicDB

A playground for experimenting with Ecto.

## Installation

### Prerequisites

   * Elixir >= 1.5 (1.9 recommended)
   * PostgreSQL >= 9.0 (MySQL or SQLite may work - see "Other Databases" below)

### Database Configuration

By default, the app will attempt to connect to the database using your system username and an empty password. If your database needs different credentials, you'll need to set up the following environment variables:

```bash
export DATABASE_USERNAME=[your username]
export DATABASE_PASSWORD=[your password]
```

### Setup

Clone the repo, then run:

```bash
bin/setup
```

This will check for Elixir, load dependencies, setup the database, and run a few smoke tests to verify that the app is communicating with the database.

If all goes well, you'll see this at the end:

```bash
Setup complete - everything looks good! 👍
```

## Other Databases

This is app has been tested with PostgreSQL, but other databases supported by Ecto may work. If you want to use a different database, you'll need to:

   1. Add the database driver as a dependency in the `deps` function in `mix.exs`
   1. Change the `adapter` setting in `lib/music_db/repo.ex`

See the [Ecto README](https://github.com/elixir-ecto/ecto) for a list of supported adapters and driver dependencies.

## Data Model

This app sets up four schemas: `Artist`, `Album`, `Track`, and `Genre.` To help keep things simple, they're fairly stripped down, and have a minimal configuration. See the corresponding modules for details.

As you might expect, Artist `has_many` Albums, which `has_many` Tracks. Albums has a `many_to_many` relationship with Genres.

![data model](https://github.com/darinwilson/music_db_workshop/blob/master/music_db_data_model.png)
