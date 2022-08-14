# frozen_string_literal: true

require 'open-uri'
url = 'https://www.reddit.com/r/WhitePeopleTwitter/top.json'
uri = URI(url)

File.open('info.json', 'w') do |file|
  file.puts uri.read
end

# search for hentai, rule 34, anime and porn in the same word
