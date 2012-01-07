class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :user_id
      t.integer :model_id
      t.string :model_type
      t.string :action

      t.timestamps
    end
  end
end
