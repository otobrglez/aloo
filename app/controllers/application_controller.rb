class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from Board::RecordNotFound, :with => :record_not_found

  private
  def record_not_found
    return redirect_to '/404', status:404
  end
end
