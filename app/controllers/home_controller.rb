class HomeController < ApplicationController
  def index
    @board = Board.new
    render :index, layout: false
  end
end
