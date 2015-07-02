class GamesPlayer < ActiveRecord::Base

  belongs_to :player
  belongs_to :game

  validates :player_number, presence: true, uniqueness: { scope: :game_id }
  validates :player_position, presence: true
  validate :check_game_users, on: :create

  private
  def check_game_users
    if game.present? && game.players.length >= 2
      errors.add(:game, "cannot have more than two players")
    end
  end
end