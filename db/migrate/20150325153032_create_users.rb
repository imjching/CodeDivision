class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, limit: 100
      t.string :password, null: false
      t.string :password_salt, null: false
      t.string :full_name, null: false
      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
