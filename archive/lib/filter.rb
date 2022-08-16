# frozen_string_literal: true


input_file = File.open('unclean_subreddit_lists/nsfw/unclean_50k.txt', 'r')

output_file = File.open('unclean_subreddit_lists/nsfw/unclean_50k.txt', 'w')


lines = input_file.readlines


lines.each do |line|
  if line.chomp.start_with? '[r/'
    output_file.puts line[1..line.index(']') - 1]
  end
end
