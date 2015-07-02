class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :initials, null: false, unique: true
      t.timestamps null: false
    end
  end
end
