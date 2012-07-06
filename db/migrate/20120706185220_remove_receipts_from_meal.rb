class RemoveReceiptsFromMeal < ActiveRecord::Migration
  def up
    remove_column :meals, :receipt
    remove_column :meals, :atl_receipt
  end

  def down
    add_column :meals, :atl_receipt, :integer
    add_column :meals, :receipt, :integer
  end
end
