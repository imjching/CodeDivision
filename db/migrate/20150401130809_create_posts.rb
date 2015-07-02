class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, unique: true
      t.string :url, unique: true
      t.text :description, null: false
      t.references :user
      t.timestamps null: false
    end
  end
end
