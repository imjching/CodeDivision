class CreateGamesPlayers < ActiveRecord::Migration
  def change
    create_table :games_players do |t|
      t.integer :game_id, null: false
      t.integer :player_id, null: false
      t.integer :player_number, null: false
      t.integer :player_position, null: false
      t.timestamps null: false
    end
  end
end
