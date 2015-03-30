class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :time_taken, null: false
      t.timestamps null: false
    end
  end
end
