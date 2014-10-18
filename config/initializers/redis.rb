if Rails.env.test?
  $redis = Redis.new driver: :hiredis
# elsif Rails.env.development?
#   $redis = Rails.new driver: :hiredis
#
end
