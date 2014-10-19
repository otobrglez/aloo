(($, window) ->
  class BoardDashboard
    defaults: {}
    constructor: (el, options) ->
      @options = $.extend({}, @defaults, options)
      @$el = $(el)

      @$el.find('#tabs a[data-toggle="tab"]').on 'shown.bs.tab', (e)=>
        target = $(e.target).attr("href").replace("Table","Chart")
        canvas = @$el.find("canvas").removeClass("visible")
        @$el.find(target).addClass("visible")

      line_config = @lineConfig()
      bar_config = @barConfig()
      @weeksChart = @createWeeksChart(@configForWeeksChart(), line_config)
      @quartersChart = @createQuartersChart(@configForQuartersChart(), bar_config)

      @$el

    createWeeksChart: (data,options={})->
      context = @$el.find('#weeksChart').get(0).getContext("2d")
      chart = new Chart(context)
      chart.Line(data, options)

    createQuartersChart: (data,options={})->
      context = @$el.find('#quartersChart').get(0).getContext("2d")
      chart = new Chart(context)
      chart.Bar(data, options)

    lineConfig: ->
      animation: false
      responsive: true
      maintainAspectRatio: false
      scaleShowGridLines: true
      showScale: false
      showTooltips: true
      segmentStrokeWidth: 1
      scaleGridLineColor : "rgba(0,0,0,.05)"
      scaleGridLineWidth : 1
      bezierCurve : true
      bezierCurveTension : 0.4
      pointDot : true
      pointDotRadius : 2
      pointDotStrokeWidth : 0
      pointHitDetectionRadius : 20
      datasetStroke : true
      datasetStrokeWidth : 1
      datasetFill : true

    barConfig: ->
      animation: false
      responsive: true
      maintainAspectRatio: false
      scaleShowGridLines: true
      pointDot: true
      showScale: false
      showTooltips: true
      segmentStrokeWidth: 1
      scaleBeginAtZero : true
      scaleShowGridLines : true
      scaleGridLineColor : "rgba(0,0,0,.05)"
      scaleGridLineWidth : 1
      barShowStroke : true
      barStrokeWidth : 1
      barValueSpacing : 30
      barDatasetSpacing : 10

    datasetForWeekChart: (i,j)->
      {
        fillColor: "rgba(230,230,230,0.2)"
        strokeColor: "rgba(240,240,240,0.3)"
        pointColor: "rgba(220,220,220,1)"
        pointStrokeColor: "#fff"
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(220,220,220, 0.3)"
        data: _.map($(i).find("td"), (i)-> $.trim($(i).text()))
      }

    datasetForQuartersChart: (i,j)->
      {
        fillColor: "rgba(230,230,230,0.2)"
        strokeColor: "rgba(240,240,240,0.3)"
        pointColor: "rgba(220,220,220,1)"
        pointStrokeColor: "#fff"
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(220,220,220, 0.3)"
        data: _.map($(i).find("td"), (i)-> $.trim($(i).text()))
      }

    configForWeeksChart: ->
      {
        labels: _.rest(_.map(@$el.find('#weeksTable thead th'), (i)->$(i).text())),
        datasets: _.map(@$el.find('#weeksTable tbody tr'), (i,j)=>@datasetForWeekChart(i,j))
      }

    configForQuartersChart: ->
      {
        labels: _.rest(_.map(@$el.find('#quartersTable thead th'), (i)->$(i).data('label'))),
        datasets: _.map(@$el.find('#quartersTable tbody tr'), (i,j)=>@datasetForQuartersChart(i,j))
      }


  $.fn.extend boardDashboard: (option, args...) ->
    @each ->
      $this = $(this)
      data = $this.data('boardDashboard')

      if !data
        $this.data 'boardDashboard', (data = new BoardDashboard(this, option))
      if typeof option == 'string'
        data[option].apply(data, args)

) window.jQuery, window

$(document).ready ->
  $('body.boards-show').boardDashboard()
