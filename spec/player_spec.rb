# frozen_string_literal: true

require_relative '../lib/player'

describe Player do

  context '#ask_for_move' do
    subject(:ask_for_move_player) { described_class.new(game_piece) }
    let(:game_piece) { double('X') }

    it 'calls #gets' do
      input = '1'

      allow(ask_for_move_player).to receive(:gets).and_return(input)

      expect(ask_for_move_player).to receive(:gets)
      ask_for_move_player.ask_for_move
    end

    it 'returns the value from gets' do
      input = '1'

      allow(ask_for_move_player).to receive(:gets).and_return(input)

      expect(ask_for_move_player.ask_for_move).to eq(input)
    end

    it 'reprompts if input is not between 1 and 7' do
      letter = 'l'
      input = '1'

      allow(ask_for_move_player).to receive(:gets).and_return(letter, input)

      expect(ask_for_move_player).to receive(:gets).twice
      expect(ask_for_move_player.ask_for_move).to eq(input)
    end

    it 'tells the player what to input' do
      input = '1'
      message = 'Enter a number 1-7 to choose a column!'

      allow(ask_for_move_player).to receive(:gets).and_return(input)

      expect(ask_for_move_player).to receive(:puts).with(message).once
      ask_for_move_player.ask_for_move
    end

    it 'tells the player what to input twice if first input is invalid' do

      letter = 'l'
      input = '1'
      message = 'Enter a number 1-7 to choose a column!'

      allow(ask_for_move_player).to receive(:gets).and_return(letter, input)

      expect(ask_for_move_player).to receive(:puts).with(message).twice
      ask_for_move_player.ask_for_move
    end

    it 'continues to ask multiple times' do
      letter1 = 'a'
      letter2 = 'l'
      bad_num = '11'
      bad_num2 = '-1'
      bad_num3 = '8'
      input = '1'
      message = 'Enter a number 1-7 to choose a column!'

      allow(ask_for_move_player).to receive(:gets).and_return(letter1, letter2, bad_num, bad_num2, bad_num3, input)

      expect(ask_for_move_player).to receive(:puts).with(message).exactly(6).times
      ask_for_move_player.ask_for_move
    end
  end

end
