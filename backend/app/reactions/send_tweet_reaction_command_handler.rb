# frozen_string_literal: true

class SendTweetReactionCommandHandler
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_API_PUBLIC"]
      config.consumer_secret = ENV["TWITTER_API_SECRET"]
      config.access_token = "1077375026804989952-d1PoJJZi7B9t8RrlrgjME5OZsOQWQs"
      config.access_token_secret = "snDhYmKpWSm2PYffFs66OfkJP62v491ZstTT8jR7GX0BH"
    end
  end

  def call(attributs)
    puts "Send Tweet Command Handler"
    @client.update(attributs[:message])
  end
end