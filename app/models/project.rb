require 'digest/sha1'
class Project < ActiveRecord::Base
  validates :name, presence: true
  after_create :build_secret
  has_many :groups, dependent: :destroy

  def build_secret
    max_size = 24
    text_id = self.id.to_s(16)
    length = text_id.size

    self.secret = text_id + SecureRandom.hex(max_size-length)
    self.save
  end

  def import(requests)
    Rails.logger.debug "Decode64 data"
    data_requests = Base64.strict_decode64(requests)
    Rails.logger.debug "Decompressing data"
    data_requests = Zlib::Inflate.inflate(data_requests)
    Rails.logger.debug "Load YAML data"
    data_requests = YAML.load(data_requests)
    Rails.logger.debug "Parsing data..."
    data_requests.each do |request|
      Rails.logger.debug request.symbolize_keys.inspect
      import_one(request)
    end
  end

  def import_one(request_data)
    group = self.groups.find_or_initialize_by_location(request_data[:location])
    group.controller = request_data[:controller]
    group.action = request_data[:action]
    if group.save
      request = group.requests.new
      request.cpu = request_data[:cpu]
      request.ram = request_data[:ram]
      request.params = request_data[:params]
      request.format = request_data[:format]
      request.method = request_data[:method]
      request.path = request_data[:path]
      request.request_time = request_data[:request_time]
      request.start_time = request_data[:start_time]
      request.env = request_data[:environment]
      request.save
      Rails.logger.debug request.errors.full_messages.join(", ")
    end
  end

  def errors_count
    self.groups.count
  end
end
