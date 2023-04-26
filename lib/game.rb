#frozen_string_literal: true

require_relative 'player'
require_relative 'board'

class Game
  def initialize
    @player_one = Player.new('X')
    @player_two = Player.new('O')
    @board = Board.new(@player_one.game_piece, @player_two.game_piece)
    @current_player = @player_one
  end

  def play_game
    set_up
    @board.print_board
    play_rounds
    wrap_up
  end

  def set_up
    welcome_message
  end

  def welcome_message
    puts 'Welcome to Connect Four'
  end

  def play_rounds
    until @board.board_full?
      puts "Player #{@current_player.game_piece} you're up!"
      column = get_move
      @board.record_move(column, @current_player.game_piece)
      @board.print_board
      switch_current_player
      break if @board.winner?
    end
  end

  def get_move
    loop do
      column = @current_player.ask_for_move
      return column if @board.column_open?(column)

      puts 'Column is full. Try again!'
    end
  end

  def wrap_up
    final_message
    prompt_for_new_game
  end

  def final_message
    puts ''
    puts '********************************'
    puts '********************************'
    if @board.winner.nil?
      puts "********* It's a draw! *********"
    elsif @board.winner == @player_one.game_piece
      puts "******** Player #{@player_one.game_piece} wins! ********"
    elsif @board.winner == @player_two.game_piece
      puts "******** Player #{@player_two.game_piece} wins! ********"
    end
    puts '********************************'
    puts '********************************'
  end

  def prompt_for_new_game
    puts ''
    puts '-------------------------------------------'
    puts '-------------------------------------------'
    puts '-------------------------------------------'
    puts '------ Would you like to play again? ------'
    puts '-------------------------------------------'
    puts '-------------------------------------------'
    if new_game_input
      new_game = Game.new
      new_game.play_game
    end
  end

  def new_game_input
    new_game_decision = nil
    loop do
      puts 'Enter 1 to start a new game or 2 to exit!'
      new_game_decision = gets.chomp
      break if new_game_decision.match(/^[1-2]$/)
    end
    new_game_decision == '1'
  end

  def switch_current_player
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end
end

game = Game.new
game.play_game
