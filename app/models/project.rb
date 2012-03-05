require 'digest/sha1'
class Project < ActiveRecord::Base
  validates :name, presence: true
  after_create :build_secret
  has_many :crash_groups, dependent: :destroy
  has_many :crashes, through: :crash_groups

  def build_secret
    max_size = 24
    text_id = self.id.to_s(16)
    length = text_id.size

    self.secret = text_id + SecureRandom.hex(max_size-length)
    self.save
  end

  def import(crashes)
    puts "importing #{crashes.size}"
    YAML.load(crashes).each do |crash|
      import_one(crash.symbolize_keys)
    end
  end

  def import_one(crash)
    raw_msg = crash[:exception][:message].gsub(/0x[0-9A-Z]+/i, '')
    crash_group_hash = Digest::SHA1.hexdigest([self.id, crash[:location], raw_msg, crash[:exception][:class_name]].compact.join("-"))
    crash_group = self.crash_groups.find_or_initialize_by_hash_uid(crash_group_hash)
    crash_group.message ||= crash[:exception][:message]
    crash_group.class_name = crash[:exception][:class_name]
    crash_group.location = crash[:location]
    crash_group.last_error_time = Time.zone.now
    crash_group.crashes_count ||= 0
    crash_group.crashes_count += 1
    crash_group.resolved = false
    if crash_group.save
      crash_group.crashes.create backtrace: crash[:exception][:backtrace], env: crash[:environment]
    end
  end

  def errors_count
    self.crash_groups.sum(:crashes_count) || 0
  end
end
