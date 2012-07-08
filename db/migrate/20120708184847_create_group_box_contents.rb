class CreateGroupBoxContents < ActiveRecord::Migration
  def change
    create_table :group_box_contents do |t|
      t.integer :group_box_meal_id
      t.string :name
      t.float :quantity
      t.string :unit

      t.timestamps
    end
  end
end
