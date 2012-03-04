class Crash < ActiveRecord::Base
  belongs_to :crash_group

  serialize :backtrace
  serialize :env
end
