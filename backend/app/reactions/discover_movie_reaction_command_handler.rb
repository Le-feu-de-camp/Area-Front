# frozen_string_literal: true

class DiscoverMovieReactionCommandHandler
  def initialize
  end

  def call(attributes)
    puts "Discover Movie Command Handler" unless Rails.env.test?

    begin
      infos = HTTParty.get("https://api.themoviedb.org/3/discover/movie?api_key=#{ENV["MOVIE_DB_KEY"]}&language=#{attributes[:language]}&region=#{attributes[:region]}&sort_by=vote_average.desc&include_adult=#{attributes[:adult]}&include_video=true&page=1&release_date.gte=#{attributes[:min_date]}&vote_count.gte=50&vote_average.gte=#{attributes[:min_score]}&without_genres=documentary&watch_region=FR")
      nbPage = infos["total_pages"].to_i
      nbPage = nbPage >= 500 ? 499 : nbPage
    rescue NoMethodError
      puts "Error: The Movie DB return null"
      return false
    end


    begin
      movies = HTTParty.get("https://api.themoviedb.org/3/discover/movie?api_key=#{ENV["MOVIE_DB_KEY"]}&language=#{attributes[:language]}&region=#{attributes[:region]}&sort_by=vote_average.desc&include_adult=#{attributes[:adult]}&include_video=true&page=#{rand(1..nbPage)}&release_date.gte=#{attributes[:min_date]}&vote_count.gte=50&vote_average.gte=#{attributes[:min_score]}&without_genres=documentary&watch_region=FR")
      movie = movies["results"][rand(0..movies["results"].length)]
      date = DateTime.now.strftime("%d/%m/%Y")
    rescue NoMethodError
      puts "Error: The Movie DB return null"
      return false
    end


    puts movie

    user = User.find(attributes[:user_id])
    gmail = GmailClient.new(user.google_token, user.email)
    gmail.send_mail(
      user.email,
      "AREA Movie Recommandation (#{date})",
      movie
    )
  end
end
