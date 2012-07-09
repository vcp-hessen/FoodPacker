class AddReceiptNameToGroupBoxMeals < ActiveRecord::Migration
  def change
    add_column :group_box_meals, :receipt_name, :string
  end
end
