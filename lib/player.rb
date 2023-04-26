#frozen_string_literal: true

class Player
  attr_reader :game_piece

  def initialize(game_piece)
    @game_piece = game_piece
  end

  def ask_for_move
    loop do
      column = verify_input(player_input)
      return column if column
    end
  end

  def verify_input(input)
    return input if input.match?(/^[1-7]$/)
  end

  def player_input
    puts 'Enter a number 1-7 to choose a column!'
    gets.chomp
  end

end