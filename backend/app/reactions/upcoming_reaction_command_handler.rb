# frozen_string_literal: true

class UpcomingReactionCommandHandler
  def initialize
  end

  def call(attributes)
    puts "Upcoming Movies Command Handler" unless Rails.env.test?

    movies = HTTParty.get("https://api.themoviedb.org/3/movie/upcoming?api_key=#{ENV["MOVIE_DB_KEY"]}&language=fr-FR&page=1&region=FR")
    unless movies["results"]
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

    gmail = GmailClient.new(attributes[:token], attributes[:email])
    gmail.send_mail(
      attributes[:email],
      "AREA Upcoming Movies (#{date})",
      result
    )
  end
end
