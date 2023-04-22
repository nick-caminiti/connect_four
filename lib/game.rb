#frozen_string_literal: true

require_relative 'player'
require_relative 'board'

class Game
  def initialize
    @board = Board.new
    @player_one = Player.new
    @player_two = Player.new
  end

end