class CreateGroupMeals < ActiveRecord::Migration
  def change
    create_table :group_meals do |t|
      t.integer :group_id
      t.integer :meal_id
      t.integer :participants_count_deviation
      t.float :hunger_factor
      t.integer :receipt_id

      t.timestamps
    end
  end
end
