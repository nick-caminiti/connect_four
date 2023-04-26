# frozen_string_literal: true

require_relative '../lib/board'

describe Board do 

  context 'board exists' do
    let(:game_piece_one) { double('game piece one') }
    let(:game_piece_two) { double('game piece two') }
    subject(:board_exists) { described_class.new(game_piece_one, game_piece_two) }
    it 'stores an array in @game_board' do
      game_board = board_exists.instance_variable_get(:@game_board)
      expect(game_board).to be_an Array
    end

    it '@game_board is an array of 6 arrays' do
      game_board = board_exists.instance_variable_get(:@game_board)
      expect(game_board[0]).to be_an Array
      expect(game_board[1]).to be_an Array
      expect(game_board[2]).to be_an Array
      expect(game_board[3]).to be_an Array
      expect(game_board[4]).to be_an Array
      expect(game_board[5]).to be_an Array
    end

    it '@game_board subarrays contain spaces' do
      game_board = board_exists.instance_variable_get(:@game_board)
      expect(game_board[0][1]).to eq(' ')
      expect(game_board[1][2]).to eq(' ')
      expect(game_board[2][3]).to eq(' ')
      expect(game_board[3][4]).to eq(' ')
      expect(game_board[4][5]).to eq(' ')
      expect(game_board[5][6]).to eq(' ')
    end

    context '#print_board' do
      let(:game_piece_one) { double('game piece one') }
      let(:game_piece_two) { double('game piece two') }
      subject(:print_board_instance) { described_class.new(game_piece_one, game_piece_two) }

      # lab2, lab1, sep6, row6, sep5, row5, sep4, row4, sep3, row3, sep2, row2, sep1, row1

      it 'prints board' do
        lab2 = ' | 1 | 2 | 3 | 4 | 5 | 6 | 7 |'
        lab1 = ' |___|___|___|___|___|___|___|'
        row6 = ' |   |   |   |   |   |   |   |'
        sep6 = ' |---+---+---+---+---+---+---|'
        row5 = ' |   |   |   |   |   |   |   |'
        sep5 = ' |---+---+---+---+---+---+---|'
        row4 = ' |   |   |   |   |   |   |   |'
        sep4 = ' |---+---+---+---+---+---+---|'
        row3 = ' |   |   |   |   |   |   |   |'
        sep3 = ' |---+---+---+---+---+---+---|'
        row2 = ' |   |   |   |   |   |   |   |'
        sep2 = ' |---+---+---+---+---+---+---|'
        row1 = ' |   |   |   |   |   |   |   |'
        sep1 = ' |---+---+---+---+---+---+---|'

        # game_board = print_board_instance.instance_variable_get(:@game_board)
        expect(print_board_instance).to receive(:puts).with(lab2)
        expect(print_board_instance).to receive(:puts).with(lab1)
        expect(print_board_instance).to receive(:puts).with(row6)
        expect(print_board_instance).to receive(:puts).with(sep6)
        expect(print_board_instance).to receive(:puts).with(row5)
        expect(print_board_instance).to receive(:puts).with(sep5)
        expect(print_board_instance).to receive(:puts).with(row4)
        expect(print_board_instance).to receive(:puts).with(sep4)
        expect(print_board_instance).to receive(:puts).with(row3)
        expect(print_board_instance).to receive(:puts).with(sep3)
        expect(print_board_instance).to receive(:puts).with(row2)
        expect(print_board_instance).to receive(:puts).with(sep2)
        expect(print_board_instance).to receive(:puts).with(row1)
        expect(print_board_instance).to receive(:puts).with(sep1)

        print_board_instance.print_board
      end

      it 'prints board when there are pieces in play' do
        board_with_pieces = Array.new(6) { Array.new(7, ' ') }
        board_with_pieces[5][0] = 'X'
        board_with_pieces[5][1] = 'O'
        board_with_pieces[5][3] = 'X'
        board_with_pieces[4][3] = 'O'

        print_board_instance.instance_variable_set(:@game_board, board_with_pieces)

        lab1 = ' | 1 | 2 | 3 | 4 | 5 | 6 | 7 |'
        lab2 = ' |___|___|___|___|___|___|___|'
        row0 = ' |   |   |   |   |   |   |   |'
        sep0 = ' |---+---+---+---+---+---+---|'
        row1 = ' |   |   |   |   |   |   |   |'
        sep1 = ' |---+---+---+---+---+---+---|'
        row2 = ' |   |   |   |   |   |   |   |'
        sep2 = ' |---+---+---+---+---+---+---|'
        row3 = ' |   |   |   |   |   |   |   |'
        sep3 = ' |---+---+---+---+---+---+---|'
        row4 = ' |   |   |   | O |   |   |   |'
        sep4 = ' |---+---+---+---+---+---+---|'
        row5 = ' | X | O |   | X |   |   |   |'
        sep5 = ' |---+---+---+---+---+---+---|'

        expect(print_board_instance).to receive(:puts).with(lab1)
        expect(print_board_instance).to receive(:puts).with(lab2)
        expect(print_board_instance).to receive(:puts).with(row0)
        expect(print_board_instance).to receive(:puts).with(sep0)
        expect(print_board_instance).to receive(:puts).with(row1)
        expect(print_board_instance).to receive(:puts).with(sep1)
        expect(print_board_instance).to receive(:puts).with(row2)
        expect(print_board_instance).to receive(:puts).with(sep2)
        expect(print_board_instance).to receive(:puts).with(row3)
        expect(print_board_instance).to receive(:puts).with(sep3)
        expect(print_board_instance).to receive(:puts).with(row4)
        expect(print_board_instance).to receive(:puts).with(sep4)
        expect(print_board_instance).to receive(:puts).with(row5)
        expect(print_board_instance).to receive(:puts).with(sep5)

        print_board_instance.print_board
      end
    end

    context '#winner?' do
      let(:game_piece_one) { double('X') }
      let(:game_piece_two) { double('O') }
      subject(:check_for_winner) { described_class.new(game_piece_one, game_piece_two) }

      before do
        check_for_winner.instance_variable_set(:@game_piece_one, 'X')
        check_for_winner.instance_variable_set(:@game_piece_two, 'O')
      end

      it 'returns false if the board is empty' do
        expect(check_for_winner.winner?).to eq(false)
      end

      it 'returns true if there are 4 consecutive Xs in the bottom row' do
        board_with_pieces = Array.new(6) { Array.new(7, ' ') }
        board_with_pieces[5][0] = 'X'
        board_with_pieces[5][1] = 'X'
        board_with_pieces[5][2] = 'X'
        board_with_pieces[5][3] = 'X'

        check_for_winner.instance_variable_set(:@game_board, board_with_pieces)

        expect(check_for_winner.winner?).to eq(true)
      end

      it 'returns true if there are 4 consecutive Xs in the top row' do
        board_with_pieces = Array.new(6) { Array.new(7, ' ') }
        board_with_pieces[0][3] = 'X'
        board_with_pieces[0][4] = 'X'
        board_with_pieces[0][5] = 'X'
        board_with_pieces[0][6] = 'X'

        check_for_winner.instance_variable_set(:@game_board, board_with_pieces)

        expect(check_for_winner.winner?).to eq(true)
      end

      it 'returns true if there are 4 consecutive Os in the right column' do
        board_with_pieces = Array.new(6) { Array.new(7, ' ') }
        board_with_pieces[5][0] = 'O'
        board_with_pieces[4][0] = 'O'
        board_with_pieces[3][0] = 'O'
        board_with_pieces[2][0] = 'O'

        check_for_winner.instance_variable_set(:@game_board, board_with_pieces)

        expect(check_for_winner.winner?).to eq(true)
      end

      it 'returns true if there are 4 consecutive Xs in the left column' do
        board_with_pieces = Array.new(6) { Array.new(7, ' ') }
        board_with_pieces[0][6] = 'X'
        board_with_pieces[1][6] = 'X'
        board_with_pieces[2][6] = 'X'
        board_with_pieces[3][6] = 'X'

        check_for_winner.instance_variable_set(:@game_board, board_with_pieces)

        expect(check_for_winner.winner?).to eq(true)
      end

      it 'returns true if there are 4 consecutive Xs in a diagonal' do
        board_with_pieces = Array.new(6) { Array.new(7, ' ') }
        board_with_pieces[0][0] = 'X'
        board_with_pieces[1][1] = 'X'
        board_with_pieces[2][2] = 'X'
        board_with_pieces[3][3] = 'X'

        check_for_winner.instance_variable_set(:@game_board, board_with_pieces)

        expect(check_for_winner.winner?).to eq(true)
      end

      it 'returns false if there is a mix of Xs and Os in a diagonal' do
        board_with_pieces = Array.new(6) { Array.new(7, ' ') }
        board_with_pieces[0][0] = 'X'
        board_with_pieces[1][1] = 'O'
        board_with_pieces[2][2] = 'X'
        board_with_pieces[3][3] = 'O'

        check_for_winner.instance_variable_set(:@game_board, board_with_pieces)

        expect(check_for_winner.winner?).to eq(false)
      end

      it 'returns false if there is a bunch of pieces' do
        board_with_pieces = Array.new(6) { Array.new(7, ' ') }
        board_with_pieces[0][0] = 'X'
        board_with_pieces[1][1] = 'O'
        board_with_pieces[2][2] = 'X'
        board_with_pieces[3][3] = 'O'
        board_with_pieces[5][0] = 'X'
        board_with_pieces[5][1] = 'O'
        board_with_pieces[5][2] = 'X'
        board_with_pieces[5][3] = 'O'

        check_for_winner.instance_variable_set(:@game_board, board_with_pieces)

        expect(check_for_winner.winner?).to eq(false)
      end

    end

    context '#record_move' do
      let(:game_piece_one) { double('game piece one') }
      let(:game_piece_two) { double('game piece two') }
      subject(:record_move_board) { described_class.new(game_piece_one, game_piece_two) }

      before do
        record_move_board.instance_variable_set(:@game_piece_one, 'X')
        record_move_board.instance_variable_set(:@game_piece_two, 'O')
      end

      it 'adds to the bottom of an empty board' do
        column = 2
        game_piece = 'X'
        board_with_pieces = Array.new(6) { Array.new(7, ' ') }
        board_with_pieces[5][1] = 'X'

        record_move_board.record_move(column, game_piece)
        expect(record_move_board.instance_variable_get(:@game_board)).to eq(board_with_pieces)
      end

      it 'adds on top of another piece' do
        column = 2
        game_piece = 'X'
        before_board = Array.new(6) { Array.new(7, ' ') }
        before_board[5][1] = 'O'

        after_board = Array.new(6) { Array.new(7, ' ') }
        after_board[5][1] = 'O'
        after_board[4][1] = 'X'

        record_move_board.instance_variable_set(:@game_board, before_board)

        record_move_board.record_move(column, game_piece)
        expect(record_move_board.instance_variable_get(:@game_board)).to eq(after_board)
      end

      it 'takes last spot in column' do
        column = 2
        game_piece = 'X'
        before_board = Array.new(6) { Array.new(7, ' ') }
        before_board[5][1] = 'O'
        before_board[4][1] = 'X'
        before_board[3][1] = 'O'
        before_board[2][1] = 'X'
        before_board[1][1] = 'X'

        after_board = Array.new(6) { Array.new(7, ' ') }
        after_board[5][1] = 'O'
        after_board[4][1] = 'X'
        after_board[3][1] = 'O'
        after_board[2][1] = 'X'
        after_board[1][1] = 'X'
        after_board[0][1] = 'X'

        record_move_board.instance_variable_set(:@game_board, before_board)

        record_move_board.record_move(column, game_piece)
        expect(record_move_board.instance_variable_get(:@game_board)).to eq(after_board)
      end

      it 'does nothing if column is full' do
        column = 2
        game_piece = 'X'
        before_board = Array.new(6) { Array.new(7, ' ') }
        before_board[5][1] = 'O'
        before_board[4][1] = 'X'
        before_board[3][1] = 'O'
        before_board[2][1] = 'X'
        before_board[1][1] = 'X'
        before_board[0][1] = 'X'

        after_board = Array.new(6) { Array.new(7, ' ') }
        after_board[5][1] = 'O'
        after_board[4][1] = 'X'
        after_board[3][1] = 'O'
        after_board[2][1] = 'X'
        after_board[1][1] = 'X'
        after_board[0][1] = 'X'

        record_move_board.instance_variable_set(:@game_board, before_board)

        record_move_board.record_move(column, game_piece)
        expect(record_move_board.instance_variable_get(:@game_board)).to eq(after_board)
      end
    end

    context '#column_open/#board_full' do
      let(:game_piece_one) { double('game piece one') }
      let(:game_piece_two) { double('game piece two') }
      subject(:board_open) { described_class.new(game_piece_one, game_piece_two) }

      before do
        board_open.instance_variable_set(:@game_piece_one, 'X')
        board_open.instance_variable_set(:@game_piece_two, 'O')
      end

      it '#column_open returns true if column is empty' do
        column = 2
        game_piece = 'X'

        expect(board_open.column_open?(column)).to eq(true)
      end

      it '#column_open returns true if column is half full' do
        column = 2
        game_piece = 'X'

        before_board = Array.new(6) { Array.new(7, ' ') }
        before_board[5][1] = 'O'
        before_board[4][1] = 'X'
        before_board[3][1] = 'O'

        board_open.instance_variable_set(:@game_board, before_board)

        expect(board_open.column_open?(column)).to eq(true)
      end

      it '#column_open returns false if column is full' do
        column = 2
        game_piece = 'X'

        before_board = Array.new(6) { Array.new(7, ' ') }
        before_board[5][1] = 'O'
        before_board[4][1] = 'X'
        before_board[3][1] = 'O'
        before_board[2][1] = 'X'
        before_board[1][1] = 'X'
        before_board[0][1] = 'X'

        board_open.instance_variable_set(:@game_board, before_board)


        expect(board_open.column_open?(column)).to eq(false)
      end

      it '#board_full returns false if board is empty' do
        expect(board_open.board_full?).to eq(false)
      end

      it '#board_full returns false if board is partially full' do
        before_board = Array.new(6) { Array.new(7, ' ') }
        before_board[5][1] = 'O'
        before_board[4][1] = 'X'
        before_board[3][1] = 'O'
        before_board[2][0] = 'X'
        before_board[1][1] = 'X'
        before_board[0][1] = 'X'

        board_open.instance_variable_set(:@game_board, before_board)

        expect(board_open.board_full?).to eq(false)
      end

      it '#board_full returns true if board is full' do
        before_board = Array.new(6) { Array.new(7, 'X') }

        board_open.instance_variable_set(:@game_board, before_board)

        expect(board_open.board_full?).to eq(true)
      end

    end
  end
end