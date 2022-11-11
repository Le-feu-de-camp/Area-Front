# frozen_string_literal: true

class LikePlaylistReactionCommandHandler
  def initialize
  end

  def call(attributes)
    puts "Like Playlist Command Handler" unless Rails.env.test?

    user = User.find(attributes[:user_id])

    # Get access token
    body = {
      client_id: ENV["SPOTIFY_CLIENT_ID"],
      client_secret: ENV["SPOTIFY_CLIENT_SECRET"],
      grant_type: "refresh_token",
      refresh_token: user.spotify_token
    }
    token_info = HTTParty.post("https://accounts.spotify.com/api/token", body: body)

    unless token_info["access_token"]
      puts "Error: Spotify return null"
      return
    end

    puts token_info["access_token"]

    # get user ID
    me = HTTParty.get("https://api.spotify.com/v1/me",
                      headers: { "Authorization": "Bearer #{token_info["access_token"]}" })
    unless me["id"]
      puts "Error: Spotify return null"
      return
    end

    # create new playlst
    date = DateTime.now.strftime("%d/%m/%Y")

    playlist = HTTParty.post(
      "https://api.spotify.com/v1/users/#{me["id"]}/playlists",
      body: {
        name: "Favourite titles #{date}",
        description: "All your favourite music (#{date}). Generated with AREA",
        public: false
      }.to_json,
      headers: {
        "Accept"=> "application/json",
        "Content-Type"=> "application/json",
        "Authorization"=> "Bearer #{token_info["access_token"]}"
      }
    )
    unless playlist["id"]
      puts "Error: Spotify return null"
      return
    end

    # get liked songs
    offset = 0
    begin
      loop do
        tracks = ""
        songs = HTTParty.get(
          "https://api.spotify.com/v1/me/tracks?limit=50&offset=#{offset}",
          "headers": { "Authorization": "Bearer #{token_info["access_token"]}" }
        )
        songs["items"].each do |song|
          tracks += song["track"]["uri"] + ","
        end

        HTTParty.post(
          "https://api.spotify.com/v1/playlists/#{playlist["id"]}/tracks?uris=#{CGI.escape tracks[0..-2]}",
          "headers": { "Authorization": "Bearer #{token_info["access_token"]}" }
        )

        offset += 50
        break if songs["items"].length == 0
      end
    rescue NoMethodError
      puts "Error: Spotify return null"
      return
    end
    puts "LETS GOOOOOOOOOOOOOOOOOOOOO"
  end
end
