class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.float :quantity
      t.integer :receipt_id
      t.integer :product_id

      t.timestamps
    end
  end
end
