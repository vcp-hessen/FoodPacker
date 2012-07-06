class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :name
      t.datetime :time
      t.integer :receipt_id
      t.integer :alt_receipt_id

      t.timestamps
    end
  end
end
