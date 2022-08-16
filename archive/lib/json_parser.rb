
require 'json'


st = %w[1k10k 10k50k 50k]

st.each do |path|
  File.open("unclean_subreddit_lists/nsfw/#{path}.txt", 'w') { |output_file|
    input_files = Dir.glob("jsons_listings/nsfw/#{path}/*")

    input_files.each do |input_file_path|

      File.open(input_file_path.chomp, 'r') do |input_file|
        json = JSON.parse(input_file.read)
        output_file.puts json[0]['data']['children'][0]['data']['selftext'].split
      end

    end
  }
end

# puts json[0]['data']['children'][0]['data']['selftext']