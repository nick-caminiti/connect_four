# frozen_string_literal: true

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

      it 'creates an instance variable of current player' do
        current_player = new_game.instance_variable_get(:@current_player)
        expect(current_player).not_to be_nil
      end

      it 'sets @player_one as @current_player to start game' do
        current_player = new_game.instance_variable_get(:@current_player)
        player_one = new_game.instance_variable_get(:@player_one)
        expect(current_player).to eq(player_one)
      end
    end
  end

  describe '#play_game' do
    subject(:play_game) { described_class.new }
    context 'moves through game flow' do
      before do
        board = play_game.instance_variable_get(:@board)
        allow(board).to receive(:column_open?).and_return('true')
        allow(board).to receive(:board_full?).and_return(false, true)
      end

      xit '#play_game functions' do
        play_game.play_game
      end

      xit 'calls #set_up' do
        expect(play_game).to receive(:set_up)
        play_game.play_game
      end

      xit 'calls method #print_board on @board' do
        board_instance = play_game.instance_variable_get(:@board)
        expect(board_instance).to receive(:print_board)
        play_game.play_game
      end

      xit 'calls #play_rounds' do
        expect(play_game).to receive(:play_rounds)
        play_game.play_game
      end

      xit 'calls #wrap_up' do
        expect(play_game).to receive(:wrap_up)
        play_game.play_game
      end
    end

    describe '#set_up' do
      subject(:game_set_up) { described_class.new }

      context 'sets up game' do
        it 'calls #welcome_message' do
          expect(game_set_up).to receive(:welcome_message)
          game_set_up.set_up
        end
      end
    end

    describe '#play_rounds' do
      subject(:play_rounds_game) { described_class.new }
      context 'gets current players move' do
        before do
          current_player = play_rounds_game.instance_variable_get(:@current_player)
          allow(current_player).to receive(:ask_for_move).and_return(2)
        end

        xit 'calls method #ask_for_move on @current_player' do
          board = play_rounds_game.instance_variable_get(:@board)
          current_player = play_rounds_game.instance_variable_get(:@current_player)
          allow(board).to receive(:column_open?).and_return('true')
          allow(board).to receive(:board_full?).and_return(false, true)
          expect(current_player).to receive(:ask_for_move)

          play_rounds_game.play_rounds
        end

        it 'reprompts if column is full once' do
          board = play_rounds_game.instance_variable_get(:@board)
          allow(board).to receive(:column_open?).and_return(false, true)
          message = 'Column is full. Try again!'

          expect(play_rounds_game).to receive(:puts).with(message).once
          play_rounds_game.get_move
        end

        it 'reprompts if column is full three times' do
          board = play_rounds_game.instance_variable_get(:@board)
          allow(board).to receive(:column_open?).and_return(false, false, false, true)
          message = 'Column is full. Try again!'

          expect(play_rounds_game).to receive(:puts).with(message).exactly(3).times
          play_rounds_game.get_move
        end
      end

      context 'records move on board' do
        before do
          board = play_rounds_game.instance_variable_get(:@board)
          allow(board).to receive(:column_open?).and_return('true')
          allow(board).to receive(:board_full?).and_return(false, true)
          player = play_rounds_game.instance_variable_get(:@current_player)
          allow(player).to receive(:gets).and_return('1')
        end

        it 'sends move to board by calling #record_move' do
          board = play_rounds_game.instance_variable_get(:@board)
          expect(board).to receive(:record_move)
          play_rounds_game.play_rounds
        end

        it 'send a column and a player symbol' do
          current_player = play_rounds_game.instance_variable_get(:@current_player)
          board = play_rounds_game.instance_variable_get(:@board)
          allow(current_player).to receive(:ask_for_move).and_return(2, current_player.game_piece)

          expect(board).to receive(:record_move).with(2, current_player.game_piece)
          play_rounds_game.play_rounds
        end
      end

      context '#switch_current player' do
        it 'switches current player from one to two' do
          before_player = play_rounds_game.instance_variable_get(:@player_one)
          play_rounds_game.instance_variable_set(:@current_player, before_player)

          after_player = play_rounds_game.instance_variable_get(:@player_two)

          play_rounds_game.switch_current_player
          expect(play_rounds_game.instance_variable_get(:@current_player)).to eq(after_player)
        end

        it 'switches current player from two to one' do
          before_player = play_rounds_game.instance_variable_get(:@player_two)
          play_rounds_game.instance_variable_set(:@current_player, before_player)

          after_player = play_rounds_game.instance_variable_get(:@player_one)

          play_rounds_game.switch_current_player
          expect(play_rounds_game.instance_variable_get(:@current_player)).to eq(after_player)
        end
      end

      context 'prints updated board' do
        before do
          board = play_rounds_game.instance_variable_get(:@board)
          allow(board).to receive(:column_open?).and_return('true')
          allow(board).to receive(:board_full?).and_return(false, true)
          player = play_rounds_game.instance_variable_get(:@current_player)
          allow(player).to receive(:gets).and_return('1')
        end

        it 'calls #print_board on @board' do
          board = play_rounds_game.instance_variable_get(:@board)
          expect(board).to receive(:print_board)
          play_rounds_game.play_rounds
        end
      end

      context 'switches current player' do
        before do
          board = play_rounds_game.instance_variable_get(:@board)
          allow(board).to receive(:board_full?).and_return(false, true)
          player = play_rounds_game.instance_variable_get(:@current_player)
          allow(player).to receive(:gets).and_return('1')
        end

        it 'calls #switch_current_player' do
          current_player = play_rounds_game.instance_variable_get(:@current_player)
          expect(play_rounds_game).to receive(:switch_current_player)
          play_rounds_game.play_rounds
        end
      end

      context 'game loops until winner or board full' do
        before do
          board = play_rounds_game.instance_variable_get(:@board)
          allow(board).to receive(:board_full?).and_return(false, true)
          player = play_rounds_game.instance_variable_get(:@current_player)
          allow(player).to receive(:gets).and_return('1')
        end

        it 'goes through loop twice if board is not full' do
          board = play_rounds_game.instance_variable_get(:@board)
          current_player = play_rounds_game.instance_variable_get(:@current_player)
          allow(board).to receive(:board_full?).and_return(false, false, true)

          expect(play_rounds_game).to receive(:switch_current_player).twice
          play_rounds_game.play_rounds
        end

        it 'goes through loop four times if board is not full' do
          board = play_rounds_game.instance_variable_get(:@board)
          current_player = play_rounds_game.instance_variable_get(:@current_player)
          allow(board).to receive(:board_full?).and_return(false, false, false, false, true)

          expect(play_rounds_game).to receive(:switch_current_player).exactly(4).times
          play_rounds_game.play_rounds
        end

        it 'breaks loop if there is a winner' do
          board = play_rounds_game.instance_variable_get(:@board)
          current_player = play_rounds_game.instance_variable_get(:@current_player)
          allow(board).to receive(:board_full?).and_return(false, false, false)
          allow(board).to receive(:winner?).and_return(false, true)

          expect(play_rounds_game).to receive(:switch_current_player).twice
          play_rounds_game.play_rounds
        end
      end
    end

    describe '#wrap_up' do
      subject(:wrap_up_game) { described_class.new }
      context 'wraps up game' do
        before do
          board = wrap_up_game.instance_variable_get(:@board)
          allow(board).to receive(:board_full?).and_return(false, true)
          player = wrap_up_game.instance_variable_get(:@current_player)
          allow(wrap_up_game).to receive(:gets).and_return('2')
        end

        it 'calls #final_message' do
          expect(wrap_up_game).to receive(:final_message)
          wrap_up_game.wrap_up
        end

        it 'calls #prompt_for_new_game' do
          expect(wrap_up_game).to receive(:prompt_for_new_game)
          wrap_up_game.wrap_up
        end
      end

      context '#final_message' do
        context 'if there is a winner' do
          it 'prints a message that player 1 won' do
            player_one = wrap_up_game.instance_variable_get(:@player_one)
            board = wrap_up_game.instance_variable_get(:@board)

            allow(board).to receive(:winner?).and_return(true)
            allow(board).to receive(:winner).and_return(player_one.game_piece)

            message = "Player #{player_one.game_piece} wins!"

            expect(wrap_up_game).to receive(:puts).with(message)
            wrap_up_game.final_message
          end

          it 'prints a message that player 2 won' do
            player_two = wrap_up_game.instance_variable_get(:@player_two)
            board = wrap_up_game.instance_variable_get(:@board)

            # allow(board).to receive(:winner?).and_return(true)
            allow(board).to receive(:winner).and_return(player_two.game_piece)
            message = "Player #{player_two.game_piece} wins!"

            expect(wrap_up_game).to receive(:puts).with(message)
            wrap_up_game.final_message
          end
        end

        context 'if there is no winner' do
          it 'prints draw message' do
            board = wrap_up_game.instance_variable_get(:@board)
            allow(board).to receive(:winner?).and_return(false)

            message = "It's a draw!"
            expect(wrap_up_game).to receive(:puts).with(message)
            wrap_up_game.final_message
          end
        end

        context '#prompt_for_new_game' do
          xit 'asks user for input' do
            allow(wrap_up_game).to receive(:gets).and_return('2')

            expect
            
          end

          it 'gets user input' do
            allow(wrap_up_game).to receive(:play_game)
            expect(wrap_up_game).to receive(:new_game_input)
            wrap_up_game.prompt_for_new_game
          end

          it 'starts a new gameif user enters yes' do
            # let(:play_game_double) { double('play game') }
            allow(wrap_up_game).to receive(:play_game)
            allow(wrap_up_game).to receive(:new_game_input).and_return(true)

            expect(wrap_up_game).to receive(:play_game)
            wrap_up_game.prompt_for_new_game
          end

          it 'starts a new instance of game if user enters yes' do
            allow(wrap_up_game).to receive(:play_game)
            allow(wrap_up_game).to receive(:new_game_input).and_return(true)

            expect(Game).to receive(:new)
            wrap_up_game.prompt_for_new_game
          end

          it "doesn't start a new game if user enters no" do
            allow(wrap_up_game).to receive(:play_game)
            allow(wrap_up_game).to receive(:new_game_input).and_return(false)

            expect(wrap_up_game).not_to receive(:play_game)
            wrap_up_game.prompt_for_new_game
          end
        end

        context '#new_game_input' do
          it 'returns true if user enters 1' do
            input = '1'
            message = 'Enter 1 to start a new game or 2 to exit!'

            allow(wrap_up_game).to receive(:gets).and_return(input)

            expect(wrap_up_game).to receive(:puts).with(message).once
            expect(wrap_up_game.new_game_input).to be true
          end

          it 'returns false if user enters 2' do
            input = '2'
            message = 'Enter 1 to start a new game or 2 to exit!'

            allow(wrap_up_game).to receive(:gets).and_return(input)

            expect(wrap_up_game).to receive(:puts).with(message).once
            expect(wrap_up_game.new_game_input).to be false
          end

          it 'reprompts if user enters invalid input' do
            invalid_input = '3'
            letter = 'l'
            valid_input = '1'
            message = 'Enter 1 to start a new game or 2 to exit!'

            allow(wrap_up_game).to receive(:gets).and_return(invalid_input, letter,valid_input)

            expect(wrap_up_game).to receive(:puts).with(message).exactly(3).times
            expect(wrap_up_game.new_game_input).to be true
          end
        end
      end
    end
  end

end
