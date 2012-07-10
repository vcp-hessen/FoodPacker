class AddSwitchesToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :fixed_quantity, :boolean
    add_column :ingredients, :hunger_relevant, :boolean
  end
end
