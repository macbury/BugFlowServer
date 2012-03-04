class AddLastErrorDateToCrashGroup < ActiveRecord::Migration
  def change
    add_column :crash_groups, :last_error_time, :datetime

  end
end
