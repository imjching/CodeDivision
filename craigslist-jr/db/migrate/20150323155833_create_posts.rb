class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false, limit: 32
      t.string :slug, null: false, limit: 32
      t.text :content, null: false
      t.string :author_key, null: false, limit: 36
      t.string :author_email, null: false, limit: 100
      t.belongs_to :category
      t.timestamps null: false
    end
  end
end
