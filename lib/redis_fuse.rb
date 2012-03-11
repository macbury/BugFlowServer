module RedisFuse

  def self.connect
    @redis ||= Redis.new(:host => 'localhost', :port => 6379)
  end

end