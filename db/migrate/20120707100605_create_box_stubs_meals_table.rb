class CreateBoxStubsMealsTable < ActiveRecord::Migration
  def up
    create_table :box_stubs_meals, :id => false do |t|
            t.references :box_stub
            t.references :meal
        end
        add_index :box_stubs_meals, [:box_stub_id, :meal_id]
        add_index :box_stubs_meals, [:meal_id, :box_stub_id]
  end

  def down
    drop_table :box_stubs_meals
  end
end
