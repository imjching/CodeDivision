class AddIndexToShortUri < ActiveRecord::Migration
  def change
     add_index :urls, :short_uri
  end
end
