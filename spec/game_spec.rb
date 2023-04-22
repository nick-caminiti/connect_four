require_relative '../lib/game'

describe Game do
  describe '#initialize' do
    context 'creates new game' do
      subject(:new_game) { described_class.new }

      it 'creates an instance variable of board' do
        expect(new_game.instance_variable_get(:@board)).not_to be_nil
      end

      it 'stores an instance of class Board in @board' do
        board = new_game.instance_variable_get(:@board)
        expect(board).to be_a Board
      end

      it 'creates an instance variable of player 1' do
        player_one = new_game.instance_variable_get(:@player_one)
        expect(player_one).not_to be_nil
      end

      it 'stores an instance of class Player in @player_one' do
        player_one = new_game.instance_variable_get(:@player_one)
        expect(player_one).to be_a Player
      end

      it 'creates an instance variable of player 2' do
        player_two = new_game.instance_variable_get(:@player_two)
        expect(player_two).not_to be_nil
      end

      it 'stores an instance of class Player in @player_two' do
        player_two = new_game.instance_variable_get(:@player_two)
        expect(player_two).to be_a Player
      end
    end
  end

end