class CreateCrashGroups < ActiveRecord::Migration
  def change
    create_table :crash_groups do |t|
      t.integer :project_id
      t.string :hash_uid
      t.text :message
      t.string :class_name
      t.string :location
      t.integer :crashes_count, default: 0

      t.timestamps
    end
  end
end
