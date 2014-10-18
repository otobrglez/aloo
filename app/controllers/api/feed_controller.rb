class Api::FeedController < ApplicationController
  include ActionController::Live

  def channel
    # params[:channel]
    "test*"
  end

  def index
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    redis.psubscribe(channel) do |on|
      on.pmessage do |pattern, event, data|
        response.stream.write("event: #{event}\n")
        response.stream.write("data: #{data}\n\n")
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    redis.quit
    response.stream.close
  end
end
