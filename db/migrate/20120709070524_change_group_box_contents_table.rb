class ChangeGroupBoxContentsTable < ActiveRecord::Migration
  def up
    remove_column :group_box_contents, :unit
    remove_column :group_box_contents, :name
    add_column :group_box_contents, :product_id, :integer
  end

  def down
    add_column :group_box_contents, :unit, :string
    add_column :group_box_contents, :name, :string
    remove_column :group_box_contents, :product_id
  end
end
