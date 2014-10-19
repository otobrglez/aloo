class Api::KpisController < Api::BaseController
  before_action :authenticate

  def create
    if kpis_params[:kpis].present?
      kpis_params[:kpis].each do |array|
        save_kpi @board_id, array
      end
    elsif kpi_params[:kpi].present?
      save_kpi @board_id, kpi_params[:kpi]
    end

    head :ok
  end

  private

  def save_kpi(key, params)
    attrs = ([key] + params.map(&:to_s))
    key = Kpi.new(*attrs)
    key.create!
  end

  def kpi_params
    params.permit!
  end

  def kpis_params
    params.permit!
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      Board.authenticate!(@board_id=username, @board_s=password)
    end
  end
end
