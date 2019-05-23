defmodule Twituser do
  def start do
    {:ok, producer} = GenStage.start_link(ReadFromTwitter, Application.get_env(:twituser, :twitter_username))
    {:ok, prod_con} = GenStage.start_link(ConvertToHashes, arg = :nonsense)
    {:ok, consumer} = GenStage.start_link(StoreToDatabase, "consumer")

    GenStage.sync_subscribe(prod_con, to: producer, max_demand: 50)
    GenStage.sync_subscribe(consumer, to: prod_con, max_demand: 10)
  end
end
