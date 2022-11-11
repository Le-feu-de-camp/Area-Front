# frozen_string_literal: true

class PlaylistFollowActionCommand
  def initialize(options)
    @action_id = options["action_id"]
    @widget_id = Action.find(@action_id).widget.id
    @playlist = options["playlist_id"]
    @nb_follower = options["nb_follower"] || current_nb_follow
  end

  def to_h
    { action_id: @action_id, widget_id: @widget_id, playlist: @playlist, nb_follower: @nb_follower }
  end

  private
    def current_nb_follow
      token_info = HTTParty.post(
        "https://accounts.spotify.com/api/token",
        "body": "grant_type=client_credentials&client_id=#{ENV["SPOTIFY_CLIENT_ID"]}&client_secret=#{ENV["SPOTIFY_CLIENT_SECRET"]}"
      )
      unless token_info.success?
        puts "Error: Spotify return null"
        return 0
      end

      playlist = HTTParty.get(
        "https://api.spotify.com/v1/playlists/#{@playlist}",
        "headers": { "Authorization": "Bearer #{token_info["access_token"]}" }
      )
      unless playlist.success?
        puts "Error: Spotify return null"
        return 0
      end

      playlist["followers"]["total"].to_i
    end
end
