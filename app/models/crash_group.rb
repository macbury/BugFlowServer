class CrashGroup < ActiveRecord::Base
  belongs_to :crash_groups
  has_many :crashes, dependent: :delete_all
end
