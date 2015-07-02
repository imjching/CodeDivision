class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :password, null: false
      t.string :password_salt, null: false
      t.string :full_name, null: false
      t.timestamps null: false
    end
  end
end
#TODO: about page for user
