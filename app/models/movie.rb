class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.find_in_tmdb(searchTerm)
    Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
    matching_movies = Tmdb::Movie.find(searchTerm)
    array_of_hash = []
    if(!matching_movies.empty?)
      matching_movies.each do |movie|
        array_of_hash.push({:tmdb_id => movie.id,:title => movie.title,:rating => 'R',:release_date => movie.release_date})
      end
    end
    return array_of_hash
  end
  
  def self.create_from_tmdb(movie_id)
    Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
    movieAdding = Tmdb::Movie.detail(movie_id)
    self.create!(title: movieAdding["original_title"], rating: 'R',description: movieAdding["overview"], release_date: movieAdding["release_date"])
  end
end
