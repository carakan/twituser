defmodule Twituser.Repo do
  use Ecto.Repo,
    otp_app: :twituser,
    adapter: Ecto.Adapters.Postgres
end
