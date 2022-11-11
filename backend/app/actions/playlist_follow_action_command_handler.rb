# frozen_string_literal: true

class PlaylistFollowActionCommandHandler
  def initialize
  end

  def call(attributes, spotify_service = SpotifyClient)
    puts "Playlist Follow Command Handler" unless Rails.env.test?

    spotify = spotify_service.new(nil)
    playlist = spotify.playlist_info

    unless playlist["followers"]
      puts "Error: Spotify return null"
      return false
    end

    current_follow = playlist["followers"]["total"].to_i

    last_follow = attributes[:nb_follower].to_i
    result = current_follow != last_follow

    if result
      puts "Follow Changed: #{result}"
      action = Action.find(attributes[:action_id])
      action.options["nb_follower"] = current_follow.to_s
      action.save
    end

    result
  end
end
