# frozen_string_literal: true

class SpotifyClientTest
  def initialize(token, playlist_total_followers = "10")
    @token = token
    @user_id_requests = 0
    @new_release_requests = 0
    @playlist_info_requests = 0
    @create_playlist_liked_songs = 0
    @playlist_total_followers = playlist_total_followers
  end

  def playlist_info(playlist_id)
    @playlist_info_requests += 1

    { "followers"=> { "total" => @playlist_total_followers } }
  end

  def new_release
    @new_release_requests += 1
  end

  def user_id
    @user_id_requests += 1

    { "country"=>"FR",
     "display_name"=>"User name",
     "email"=>"User email",
     "explicit_content"=>{ "filter_enabled"=>false, "filter_locked"=>false },
     "external_urls"=>{ "spotify"=>"https://open.spotify.com/user/user_pseudo" },
     "followers"=>{ "href"=>nil, "total"=>2 },
     "href"=>"https://api.spotify.com/v1/users/user_pseudo",
     "id"=>"user_speudo",
     "images"=>
      [{ "height"=>nil,
        "url"=>
         "https://scontent-frx5-1.xx.fbcdn.net/v/t1.6435-1/68834295_2951715018234899_2574324189435527168_n.jpg?stp=dst-jpg_p320x320&_nc_cat=111&ccb=1-7&_nc_sid=0c64ff&_nc_ohc=ZtmtNngfXgQAX-QEhb5&_nc_ht=scontent-frx5-1.xx&edm=AP4hL3IEAAAA&oh=00_AfDk96-CLnWjs0JDO6nnf5YH_k-Rhy2ykDN4MQm4dC82aA&oe=6397CBEB",
        "width"=>nil }],
     "product"=>"premium",
     "type"=>"user",
     "uri"=>"spotify:user:user_pseudo" }
  end

  def create_playlist_liked_songs
    @create_playlist_liked_songs += 1
  end
end
