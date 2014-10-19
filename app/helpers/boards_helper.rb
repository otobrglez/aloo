module BoardsHelper

  def example_kpi(date, value)
    kpi = [date, value]
  end


  def example_command_for_create(board)
    data = {kpi: example_kpi(Date.today, 2000)}

"curl -XPOST -H'Content-Type: application/json' -u#{@board.id}:#{@board.s} \\
-d'#{data.to_json}' \\
#{api_kpis_url}"
  end

  def example_command_for_bulk_create(board)
    kpis = ((Date.today-40.days)..(Date.today)).each_with_index.map { |date, x|
      example_kpi(date, (Math.log(x+1)*rand(200)).ceil*1000 )
    }
    data = {kpis: kpis}
"curl -XPOST -H'Content-Type: application/json' -u#{@board.id}:#{@board.s} \\
-d'#{data.to_json}' \\
#{api_kpis_url}"
  end


end
