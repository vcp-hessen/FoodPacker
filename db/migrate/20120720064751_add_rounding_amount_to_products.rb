class AddRoundingAmountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :rounding_amount, :float
  end
end
