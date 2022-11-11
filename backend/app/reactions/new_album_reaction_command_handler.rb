# frozen_string_literal: true

class NewAlbumReactionCommandHandler
  def initialize
  end

  def call(attributes, spotify_service = SpotifyClient)
    puts "New Album Command Handler" unless Rails.env.test?

    spotify = spotify_service.new(nil)

    songs = spotify.new_release
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
