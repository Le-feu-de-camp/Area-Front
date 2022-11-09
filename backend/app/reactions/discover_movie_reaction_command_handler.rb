# frozen_string_literal: true

class DiscoverMovieReactionCommandHandler
  def initialize
  end

  def call(attributes)
    puts "Discover Movie Command Handler"

    begin
      infos = HTTParty.get("https://api.themoviedb.org/3/discover/movie?api_key=#{ENV["MOVIE_DB_KEY"]}&language=fr-FR&region=FR&sort_by=vote_average.desc&include_adult=false&include_video=true&page=1&release_date.gte=1975&vote_count.gte=50&vote_average.gte=7&without_genres=documentary&watch_region=FR")
    rescue NoMethodError
      puts "Error: The Movie DB return null"
      return false
    end

    nbPage = infos["total_pages"].to_i

    begin
      movies = HTTParty.get("https://api.themoviedb.org/3/discover/movie?api_key=#{ENV["MOVIE_DB_KEY"]}&language=fr-FR&region=FR&sort_by=vote_average.desc&include_adult=false&include_video=true&page=#{rand(1..nbPage)}&release_date.gte=1975&vote_count.gte=50&vote_average.gte=7&without_genres=documentary&watch_region=FR")
    rescue NoMethodError
      puts "Error: The Movie DB return null"
      return false
    end

    movie = movies["results"][rand(0..movies["results"].length)]
    date = DateTime.now.strftime("%d/%m/%Y")

    user = User.find(attributes[:user_id])
    gmail = GmailClient.new(user.google_token, user.email)
    gmail.send_email(
      user.email,
      "AREA Movie Recommandation (#{date})",
      movie
    )
  end
end
