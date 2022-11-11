# frozen_string_literal: true

class LikePlaylistReactionCommandHandler
  def initialize
  end

  def call(attributes, spotify_service = SpotifyClient)
    puts "Like Playlist Command Handler" unless Rails.env.test?

    user = User.find(attributes[:user_id])

    spotify = spotify_service(user.spotify_token)

    begin
      spotify.create_playlist_liked_songs
    rescue Exception => e
      puts e.message
      return
    end
    puts "LETS GOOOOOOOOOOOOOOOOOOOOO"
  end
end
