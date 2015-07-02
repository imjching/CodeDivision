class LinkUsersToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :user_id, :integer
    add_index :urls, :user_id
  end
end
