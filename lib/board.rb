# frozen_string_literal: true

class Board
  attr_reader :winner

  def initialize(game_piece_one, game_piece_two)
    @game_piece_one = game_piece_one
    @game_piece_two = game_piece_two
    @winner = nil
    @game_board = create_board
    @winning_hash = {
      row: [[0, 1], [0, 2], [0, 3]],
      column: [[1, 0], [2, 0], [3, 0]],
      diagonal1: [[1, 1], [2, 2], [3, 3]],
      diagonal2: [[-1, 1], [-2, 2], [-3, 3]]
    }
  end

  def create_board
    Array.new(6) { Array.new(7, ' ') }
  end

  def print_board
    puts ' | 1 | 2 | 3 | 4 | 5 | 6 | 7 |'
    puts ' |___|___|___|___|___|___|___|'

    @game_board.each do |row|  
      puts " | #{row[0]} | #{row[1]} | #{row[2]} | #{row[3]} | #{row[4]} | #{row[5]} | #{row[6]} |"
      puts ' |---+---+---+---+---+---+---|'
    end
  end

  def winner?
    @game_board.each_with_index do |row, r_index|
      row.each_with_index do |spot, c_index|
        if [@game_piece_one, @game_piece_two].include?(spot)
          # if spot == @game_piece_one || spot == @game_piece_two
          @winner = spot if check_for_adjacent(spot, r_index, c_index)
        end
        break unless @winner.nil?
      end
    end
    @winner.nil? ? false : true
  end

  def check_for_adjacent(spot, row, column)
    @winning_hash.each do |_key, arrays|
      in_a_row = 1
      arrays.each do |coord|
        next_row = row + coord[0]
        next_column = column + coord[1]
        next if next_row.negative? || next_row > 5
        next if next_column.negative? || next_column > 6

        in_a_row += 1 if spot == @game_board[next_row][next_column]
        return true if in_a_row == 4
      end
    end
    false
  end

  def record_move(column, game_piece)
    index = 5
    column = column.to_i
    @game_board.reverse_each do |row|
      if row[column - 1] == ' '
        @game_board[index][column - 1] = game_piece
        break
      end
      index -= 1
    end
  end

  def column_open?(column)
    column = column.to_i
    @game_board.each do |row|
      return true if row[column - 1] == ' '
    end
    false
  end

  def board_full?
    @game_board.each do |row|
      row.each do |spot|
        return false if spot == ' '
      end
    end
    true
  end
end
