class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false, limit: 32
      t.string :slug, null: false, limit: 32
      t.text :content, null: false
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
