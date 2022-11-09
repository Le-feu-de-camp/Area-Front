# frozen_string_literal: true

class UpcomingReactionCommandHandler
  def initialize
  end

  def call(attributes)
    puts "Upcoming Movies Command Handler"

    begin
      movies = HTTParty.get("https://api.themoviedb.org/3/movie/upcoming?api_key=#{ENV["MOVIE_DB_KEY"]}&language=fr-FR&page=1&region=FR")
    rescue NoMethodError
      puts "Error: The Movie DB return null"
      return false
    end

    result = []
    movies["results"].each do |movie|
      result << {
        "title": movie["title"],
        "date": movie["release_date"],
        "image": "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
        "url": "https://www.themoviedb.org/movie/#{movie["id"]}",
        "overview": movie["overview"]
      }
    end

    date = DateTime.now.strftime("%d/%m/%Y")

    user = User.find(attributes[:user_id])
    gmail = GmailClient.new(user.google_token, user.email)
    gmail.send_mail(
      user.email,
      "AREA Upcoming Movies (#{date})",
      result
    )

  end
end
