class ConsoleController < ApplicationController
  def index
    @console = ConsoleForm.new()
  end

  def create
    @console = ConsoleForm.new(console_params)
    render :index
  end

  def console_params
    params[:console].permit!
  end
end
