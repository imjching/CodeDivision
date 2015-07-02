class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :name, null: false
      t.string :sorted_name, null: false
      t.timestamps null: false
    end
  end
end