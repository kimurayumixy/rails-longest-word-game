require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.shuffle[0..7]
  end

  def score
    @answer = params[:answer]
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    hash = JSON.parse(URI.open(url).read)
    grid_arr = params["letters"].split(" ")
    answer_arr = params["answer"].split("")
    included = answer_arr.all? { |answer_letter| answer_arr.count(answer_letter) <= grid_arr.count(answer_letter) }
    if hash["found"] && included
      @result = "congrats"
    elsif hash["found"] && !included
      @result = "Not included in the grid!"
    else
      @result = "Not an English word!"
    end
  end
end
