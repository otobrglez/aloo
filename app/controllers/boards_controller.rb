class BoardsController < ApplicationController
  def index
    redirect_to root_url
  end

  def create
    @board = Board.generate!(board_params)
    if @board.save
      redirect_to board_path(@board, show_help: 1)
    else
      @show_form = true
      render 'home/index', layout: false
    end
  end

  def show
    @board = Board.load(params[:id])
    @show_help = params[:show_help] || false
  end

  def stats(match, options={})
    stats = Stats.new(@board.id, match, options)
    stats.results
  end

  def short_key key
    key.gsub(@board.id, @board.id[0..2]+"..")
  end
  helper_method :short_key

  helper_method :stats

  private

  def board_params
    params[:board].permit(:name)
  end
end
