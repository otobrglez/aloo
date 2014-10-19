if Rails.env.production?
  $redis = Redis.new(url: ENV["REDISGREEN_URL"], driver: :hiredis)
elsif Rails.env.test?
  $redis = Redis.new driver: :hiredis, db: 1
else
  $redis = Redis.new driver: :hiredis, db: 0
end
