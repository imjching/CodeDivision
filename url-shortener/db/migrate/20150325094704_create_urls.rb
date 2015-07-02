class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :short_uri, null: false
      t.text :redirect_url, null: false
      t.integer :click_count, null: false, default: 0
      t.timestamps null: false
    end
  end
end