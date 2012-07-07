class CreateBoxStubs < ActiveRecord::Migration
  def change
    create_table :box_stubs do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :name

      t.timestamps
    end
  end
end
