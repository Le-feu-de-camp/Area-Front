class ClientTwitter
    def initialize(options)
        @consumer_key = ENV["TWITTER_API_PUBLIC"]
        @consumer_secret = ENV["TWITTER_API_SECRET"]
        @access_token = options["access_token"]
        @access_token_secret = options["access_token_secret"]
    end

    def get_tweets
        Typhoeus.get("https://api.twitter.com/2/tweets?ids=", headers: { "Authorization" => "Bearer 1077375026804989952-d1PoJJZi7B9t8RrlrgjME5OZsOQWQs" })
    end

    def post_tweet
        Typhoeus.post("https://api.twitter.com/2/tweets", headers: { "Authorization" => "Bearer 1586016136650440705-0TIpSLhI9kro0iyxchiNWq3YNkSM9B" },  body: { "text": "t221212"})
    end
end

##Twitter.configure do |config|
##    config.consumer_key = "fFTsVEtL2Hkh1IPLVOrof8TY3"
##    config.consumer_secret = "BqccLA0XG4w8wYFT7gAEs228vhRs3RgLf7lFTlAn9x8jiFmRik"
##    config.oauth_token = "NVZhRnR0Q3pRR3pwZ1Z4aklPbjg6MTpjaQ"
##    config.oauth_token_secret = "jNPmD4ZEGvmXRe49bo7JjV-rHycbM_-qCSZMSC4tvVIy_N2OIv"
##end
##  client = Twitter::Client.new
##  client.update("test")