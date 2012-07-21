class CreateSpecials < ActiveRecord::Migration
  def change
    create_table :specials do |t|
      t.integer :group_id
      t.integer :box_id
      t.integer :product_id
      t.float :quantity

      t.timestamps
    end
  end
end
