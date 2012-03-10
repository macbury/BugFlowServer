class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :group_id
      t.text :params
      t.string :format
      t.string :method
      t.string :path
      t.float :request_time
      t.datetime :start_time
      t.text :env
      t.float :cpu
      t.integer :ram

      t.timestamps
    end
  end
end
