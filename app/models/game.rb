class Game < ActiveRecord::Base

  has_many :games_players
  has_many :players, through: :games_players

  validates :time_taken, presence: true

  def get_player_one
    if games_players[0].player_number == 1
      return games_players[0].player.initials
    end
    return games_players[1].player.initials
  end

  def get_player_two
    if games_players[0].player_number == 2
      return games_players[0].player.initials
    end
    return games_players[1].player.initials
  end

  def winner
    if games_players[0].player_position > games_players[1].player_position
      return games_players[0].player.initials
    elsif games_players[0].player_position < games_players[1].player_position
      return games_players[1].player.initials
    end
    return "DRAW"
  end
end