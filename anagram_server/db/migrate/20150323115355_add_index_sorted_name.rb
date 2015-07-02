class AddIndexSortedName < ActiveRecord::Migration
  def change
    add_index :words, :sorted_name
  end
end
