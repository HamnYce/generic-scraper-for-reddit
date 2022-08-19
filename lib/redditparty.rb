# frozen_string_literal: true

require 'open-uri'
require 'net/http'
require 'httparty'
require 'json'

# fk this comment
class RedditParty
  include HTTParty

  CONTENT_TYPE = 'application/json'
  ACCEPT = '*/*'
  BEARER_TOKEN = '138365295012-ANGfRCSdd6X6E8WRyWqRQsa4S-SUag'

  USER_AGENT = 'homiewassup'

  base_uri 'https://oauth.reddit.com'
  headers({ 'content-type' => CONTENT_TYPE,'accept' => ACCEPT,
            'authorization' => "Bearer #{BEARER_TOKEN}",
            'user-agent' => USER_AGENT
          })

  def self.subreddit_listing(subreddit_name)
    get(subreddit_name).read_body
  end
end
