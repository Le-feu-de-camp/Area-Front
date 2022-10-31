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
        Typhoeus.post("https://api.twitter.com/2/tweets", headers: { "Authorization" => "Bearer AAAAAAAAAAAAAAAAAAAAALm6igEAAAAA0DVX5G0FcFngmvcJswCctbVfdbs%3D7RXD27nnwoZpS5cVq3AK1rXAplom3vANcUAp5zmhWSLgiGge0T" },  body: { "text": "t221212"})
    end
end