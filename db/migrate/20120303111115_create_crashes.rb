class CreateCrashes < ActiveRecord::Migration
  def change
    create_table :crashes do |t|
      t.integer :crash_group_id
      t.text :backtrace
      t.text :env

      t.timestamps
    end
  end
end
