class CreateMyTasks < ActiveRecord::Migration
  def change
    create_table :my_tasks do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
