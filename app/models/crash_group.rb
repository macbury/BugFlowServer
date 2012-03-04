class CrashGroup < ActiveRecord::Base
  belongs_to :crash_groups
  has_many :crashes, dependent: :delete_all

  def resolved?
    self.resolved
  end

  def resolve!
    self.resolved = true
    self.crashes_count = 0
    self.save
  end


end
