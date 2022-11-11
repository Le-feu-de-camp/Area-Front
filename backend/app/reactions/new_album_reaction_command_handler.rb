# frozen_string_literal: true

class NewAlbumReactionCommandHandler
  def initialize
  end

  def call(attributes)
    puts "New Album Command Handler" unless Rails.env.test?

    token_info = HTTParty.post(
      "https://accounts.spotify.com/api/token",
      "body": "grant_type=client_credentials&client_id=#{ENV["SPOTIFY_CLIENT_ID"]}&client_secret=#{ENV["SPOTIFY_CLIENT_SECRET"]}"
    )
    unless token_info["access_token"]
      puts "Error: Spotify return null"
      return false
    end

    songs = HTTParty.get(
      "https://api.spotify.com/v1/browse/new-releases?limit=5",
      "headers": { "Authorization": "Bearer #{token_info["access_token"]}" }
    )
    unless songs["albums"]["items"]
      puts "Error: Spotify return null"
      return false
    end

    result = []
    songs["albums"]["items"].each do |song|
      result << {
        "image": song["images"][0]["url"],
        "url": song["external_urls"]["spotify"],
        "title": song["name"],
        "artist": song["artists"][0]["name"]
      }
    end

    user = User.find(attributes[:user_id])

    user.songs["albums"] = result
    user.save
  end
end
