# frozen_string_literal: true

require_relative '../lib/ib/redditparty'

file = File.open('links/paths/nsfw_path_list.txt', 'r')

until file.eof?
  line = file.readline.chomp
  name = line[line.rindex('/') + 1..]
  file_type = line.split('_')[-2]

  Dir.mkdir("jsons_listings/nsfw/#{file_type}") unless Dir.exist? "jsons_listings/nsfw/#{file_type}"

  File.open("jsons_listings/nsfw/#{file_type}/#{name}.json", 'w') do |json_file|
    json = RedditParty.subreddit_listing(line)
    json_file.puts json
  end
end
