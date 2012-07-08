class CreateGroupBoxes < ActiveRecord::Migration
  def change
    create_table :group_boxes do |t|
      t.integer :group_id
      t.integer :box_id

      t.timestamps
    end
  end
end
