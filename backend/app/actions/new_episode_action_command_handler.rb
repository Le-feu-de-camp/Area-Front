# frozen_string_literal: true

class NewEpisodeActionCommandHandler
  def initialize
  end

  def call(attributes)
    puts "New Episode Command Handler"

    begin
      update = HTTParty.get("https://api.themoviedb.org/3/tv/#{attributes[:show_id]}/changes?api_key=#{ENV["MOVIE_DB_KEY"]}&page=1")
    rescue NoMethodError
      puts "Error: The Movie DB return null"
      return false
    end

    if update == :nil
      puts "Error: The Movie DB return null"
      return false
    end

    len = update["changes"].length

    if len == 0
      puts "No new episode"
      return false
    end

    for i in 0..len-1
      if update["changes"][i]["key"] == "season"
        puts "New episode"
        Widget_to_disable.append(attributs[:widget_id]) if resultat
        return true
      end
    end

    return false
  end
end
