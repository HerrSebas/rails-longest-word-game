class GamesController < ApplicationController
  require 'json'
  require 'open-uri'
  protect_from_forgery with: :null_session

  def new
    letters_array = ('A'...'Z').to_a
    @letters = letters_array.sample(10)
  end

  def score
    @word = params[:attempt]
    @grid = params[:grid]
    url = "https://wagon-dictionary.herokuapp.com/#{params[:attempt]}"
    result = JSON.parse(URI.open(url).read)

    if result["found"]
      if @word.upcase.chars.all? { |char| @grid.include?(char) && @word.upcase.count(char) <= @grid.count(char)}
        @message = 'well done'
        @score = @word.length
      else
        @message = "don´t match with the grid"
        @score = 0
      end
    else
      @score = 0
      @message = "it is not an english word"
    end
  end
end
