require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.shuffle[0..7]
  end

  def score
    @answer = params[:answer]
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    hash = JSON.parse(URI.open(url).read)
    included = (@answer.split("") - params[:letters].split(" ")).empty?

    if hash["found"] && included
      @result = "congrats"
    elsif !hash["found"] && included
      @result = "Not an English word!"
    else
      @result = "Not included in the grid!"
    end
  end
end
