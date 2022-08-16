# frozen_string_literal: true

require_relative 'redditparty'


# get the subreddit jsons according to the fuzzy finger results
class JsonScraper
  def self.search(query_term, subreddit_amount, safety, exact)
    Dir.mkdir "top_listings/#{query_term}/" unless Dir.exist? "top_listings/#{query_term}/"

    subreddits = fuzzy_query(query_term, safety, exact)

    subreddits.split[0..subreddit_amount - 1].each do |subreddit|
      puts "fetching from #{subreddit}"

      json = RedditParty.subreddit_listing("/#{subreddit}/top/?t=all")

      File.open("top_listings/#{query_term}/#{subreddit[2..]}.json", 'w') do |file|
        file.puts json
      end
    end
    subreddits.split[0..subreddit_amount - 1].count
  end

  def self.fuzzy_query(query_term, safety, exact)
    `cat subreddit_lists/#{safety}/full_list.txt | fzf --filter="#{query_term}" --algo=v2 #{exact}`
  end
end
