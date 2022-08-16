# frozen_string_literal: true

require 'json'
require 'open-uri'

# used in conjuction with client.rb once all jsons have been fetched
# scrapes all the image links and downloads them into appropriate dir
class ImageScraper
  def initialize(query_term)
    @query_term = query_term
    @file_dir = "top_listings/#{query_term}"
    @json_files = Dir.glob("#{@file_dir}/*")

    @output_dir = "images/#{@query_term}"
    Dir.mkdir @output_dir unless Dir.exist? @output_dir
  end

  def scrape_all_jsons
    @json_files.each do |json_file_path|
      json = File.open(json_file_path, 'r')
      subreddit_name = parse_subreddit_name(json_file_path)

      Dir.mkdir "#{@output_dir}/#{subreddit_name}" unless Dir.exist? "#{@output_dir}/#{subreddit_name}"

      scrape_posts(JSON.parse(json.read), subreddit_name)
    end
  end

  def scrape_posts(subreddit_json, subreddit_name)
    return if subreddit_json['reason']

    subreddit_json['data']['children'].each do |post|
      url = post_url(post)
      extension = post_extension(url)

      next unless is_image? extension

      File.open("#{@output_dir}/#{subreddit_name}/#{post_title(post)}.#{extension}", 'wb') { |image|
        image.write URI(url).read
      }
    end
  end

  def parse_subreddit_name(json_file_dir)
    json_file_dir[json_file_dir.rindex('/') + 1..json_file_dir.rindex('.') - 1]
  end

  def post_url(post_json)
    post_json['data']['url'].chomp
  end

  def post_extension(url)
    url[url.rindex('.') + 1..]
  end

  def post_title(post_json)
    post_json['data']['title'].split('/')[0][0..20]
  end

  def is_image?(extension)
    %w[png jpg jpeg gif gifv].include? extension
  end

end