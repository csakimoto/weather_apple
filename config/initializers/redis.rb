$redis ||= Redis.new(url: Rails.application.credentials.redis_uri)
