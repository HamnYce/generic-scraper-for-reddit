# frozen_string_literal : true

require 'open-uri'
require 'nokogiri'

omega_url = 'https://www.reddit.com/r/ListOfSubreddits/comments/ct9d6w/list_of_all_subreddits_1000/'

omega_uri = URI(omega_url)

