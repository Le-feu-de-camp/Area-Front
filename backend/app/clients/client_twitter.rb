class ClientTwitter
    def initialize(options)
        @consumer_key = ENV["TWITTER_API_PUBLIC"]
        @consumer_secret = ENV["TWITTER_API_SECRET"]
        @access_token = options["access_token"]
        @access_token_secret = options["access_token_secret"]
    end

    def get_tweets
        Typhoeus.get("https://api.twitter.com/2/tweets", headers: { "Authorization" => "Bearer 1077375026804989952-d1PoJJZi7B9t8RrlrgjME5OZsOQWQs" })
    end
end