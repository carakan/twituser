defmodule Twituser.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:author_name, :string)
      add(:text, :text)
      add(:retweets, :integer, default: 0)

      timestamps([type: :utc_datetime])
    end
  end
end
