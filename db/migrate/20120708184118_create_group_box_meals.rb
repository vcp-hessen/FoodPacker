class CreateGroupBoxMeals < ActiveRecord::Migration
  def change
    create_table :group_box_meals do |t|
      t.integer :group_box_id
      t.integer :meal_id
      t.integer :participants_count

      t.timestamps
    end
  end
end
