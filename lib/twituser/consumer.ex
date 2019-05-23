# this module read from a user twitter all the tweet;s
defmodule ReadFromTwitter do
  use GenStage

  def init(twitter_username) do
    {:ok, tweets} =
      try do
        Twittex.user_timeline(twitter_username)
      rescue
        _error ->
          IO.puts("There was an error connecting to the Twitter API.")
      end

    # Note we're setting tweets as the state.
    {:producer, tweets}
  end

  def handle_demand(demand, state) do
    {pulled, remaining} = Enum.split(state, demand)
    {:noreply, pulled, remaining}
  end
end


# This is a producde-consumer layer in this try to parse all the raw tweets into 
# a hash to store into the database (could be add validations/filters etc.)
defmodule ConvertToHashes do
  use GenStage
  def init(_) do
    {:producer_consumer, :ok}
  end

  # Turn a list of tweets into a list of tuples and parse the creation date.
  def handle_events(tweets, _from, _state) do

    tweets = tweets
    |> Enum.map(fn tweet ->
      {:ok, tweet_time} =
        Ecto.Type.cast(
          :utc_datetime,
          tweet["created_at"] |> Timex.parse!("%a %b %d %T %z %Y", :strftime)
        )

      %{
        id: tweet["id"], # this is uniq 
        author_name: tweet["user"]["name"],
        text: tweet["text"],
        retweets: tweet["retweet_count"],
        inserted_at: tweet_time,
        updated_at: tweet_time # I need to do that beacuse in Repo.insert_all/1 don't add magic values
      }
    end)

    {:noreply, tweets, :ok}
  end
end

# this module store to the database
defmodule StoreToDatabase do
  use GenStage
  def init(output_twitter_feed) do
    {:consumer, output_twitter_feed}
  end


  def handle_events(image_lists, _from, output_twitter_feed) do
    # to see whats happen
    Process.sleep(1000)

    # if some tweets it's already stored in database do nothing
    # beacuse to ensure not duplicate data I control using twitter API uniq id
    Twituser.Repo.insert_all(Twituser.User, image_lists, on_conflict: :nothing)

    {:noreply, [], output_twitter_feed}
  end
end
