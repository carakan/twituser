defmodule Twituser.User do
  use Ecto.Schema

  schema "users" do
    field(:author_name, :string)
    field(:text, :string)
    field(:retweets, :integer)
    timestamps([type: :utc_datetime])
  end
end
