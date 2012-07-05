class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :participants_count
      t.float :hunger_factor

      t.timestamps
    end
  end
end
