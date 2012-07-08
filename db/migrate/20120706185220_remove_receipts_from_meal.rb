class RemoveReceiptsFromMeal < ActiveRecord::Migration
  def up
    remove_column :meals, :receipt_id
    remove_column :meals, :alt_receipt_id
  end

  def down
    add_column :meals, :alt_receipt_id, :integer
    add_column :meals, :receipt_id, :integer
  end
end
