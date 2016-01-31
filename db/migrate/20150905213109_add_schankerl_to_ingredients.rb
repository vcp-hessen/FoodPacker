class AddSchankerlToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :schmakerl, :boolean, default: false
  end
end
