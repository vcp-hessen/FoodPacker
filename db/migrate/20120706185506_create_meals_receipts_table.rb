class CreateMealsReceiptsTable < ActiveRecord::Migration
  def up
    create_table :meals_receipts, :id => false do |t|
            t.references :meal
            t.references :receipt
        end
        add_index :meals_receipts, [:meal_id, :receipt_id]
        add_index :meals_receipts, [:receipt_id, :meal_id]
  end

  def down
    drop_table :meals_receipts
  end
end
