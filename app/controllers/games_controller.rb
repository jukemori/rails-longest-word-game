require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end
  def score
    p word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{word.downcase}"
    json = URI.open(url).read
    dictionary = JSON.parse(json)

  if included?(word, params[:letters]) == false
    @response = "Sorry but test can't be built out of #{params[:letters]}"
  elsif dictionary['found'] == false
    @response = "Sorry but #{word.upcase} does not seem to be a valid English word..."
  elsif dictionary['found'] == true
    @response = "Congraturations! #{word.upcase} is a valid English word!"
  end
  end

  private

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end
end
