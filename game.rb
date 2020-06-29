require_relative 'board'
require_relative 'human_player'

class Game
    attr_reader :board, :players, :display, :current_player

    def initialize(player1, player2)
        @board = Board.new
        @display = Display.new(board)
        @players = {
            :white => player1.new(:white, display), 
            :black => player2.new(:black, display)
        }
        @current_player = :white
    end

    def play
        until players.any? { |player| board.checkmate?(player) } do
            take_turn
            swap_turn!
        end
    end

    private

    def take_turn
        begin
            @players[current_player].make_move(board)
        rescue ArgumentError => error
            puts error.message
            sleep 3
            retry
        end 
    end

    def swap_turn!
        if current_player == :white
            @current_player = :black
        else
            @current_player = :white
        end
    end
end