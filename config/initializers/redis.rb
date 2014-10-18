if Rails.env.test?
  $redis = Redis.new driver: :hiredis
elsif Rails.env.development?
  $redis = Rails.new driver: :hiredis
elsif Rails.env.production?
  $redis = Redis.new(url: ENV["REDISGREEN_URL"], driver: :hiredis)
end
