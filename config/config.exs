# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :twituser, ecto_repos: [Twituser.Repo]

config :twituser, twitter_username: "carakan"

config :twituser, Twituser.Repo,
  database: "twituser_repo",
  username: "carakan",
  hostname: "localhost",
  pool_size: 10

config :twittex,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET")

# import_config "#{Mix.env()}.exs"
