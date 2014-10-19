class BoardsController < ApplicationController
  def index
    redirect_to root_url
  end

  def create
    @board = Board.generate!(board_params)
    if @board.save
      flash[:show_modal] = "help_modal"
      redirect_to board_path(@board)
    else
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

  def quads year=DateTime.now.year
    (1..4).to_a.map { |i| d=Date.new(year, i*3); [d.beginning_of_quarter, d.end_of_quarter] }
  end

  helper_method :short_key
  helper_method :stats
  helper_method :quads

  private

  def board_params
    params[:board].permit(:name)
  end
end
