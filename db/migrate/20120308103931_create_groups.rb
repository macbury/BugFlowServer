class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :project_id
      t.string :location
      t.string :controller
      t.string :action

      t.timestamps
    end
  end
end
