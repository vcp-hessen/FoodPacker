class RenameBoxStubsToBoxes < ActiveRecord::Migration
  def change
      rename_table :box_stubs, :boxes
      rename_table :box_stubs_meals, :boxes_meals
      rename_column :boxes_meals, :box_stub_id, :box_id
  end
end
