class AddResolvedToCrashGroups < ActiveRecord::Migration
  def change
    add_column :crash_groups, :resolved, :boolean, default: false

  end
end
