class CreateReciepts < ActiveRecord::Migration
  def change
    create_table :reciepts do |t|
      t.string :name

      t.timestamps
    end
  end
end
