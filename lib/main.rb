# frozen_string_literal: true

require_relative 'json_scraper'
require_relative 'image_scraper'


puts "please enter term of subreddits you would like to use?\nExample: input = 'anime'
Will search for subreddits like r/anime, r/animeArt, r/animemes etc."

query_term = gets.chomp

puts 'how many subreddits would you like to search in total?'

subreddit_amount = gets.chomp.to_i

puts "how would you like the safety to be?\ns for sfw,\nns for nsfw,\nb for both"
safety = gets.chomp.downcase

amount = if %w[s ns].include? safety
           JsonScraper.search(query_term, subreddit_amount, "#{safety}fw")
         elsif safety == 'b'
           JsonScraper.search(query_term, subreddit_amount, 'sfw') +
             JsonScraper.search(query_term, subreddit_amount, 'nsfw')
         else
           'error'
         end

# ُُTODO:: output every time a new subredit is being parsed
# TODO:: add progress bar
# TODO:: add question if the user want's new, hot, best, top
# TODO:: if top ask for day, year, all-time etc

ImageScraper.new(query_term).scrape_all_jsons
