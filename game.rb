require_relative 'board'
require_relative 'human_player'

class Game
    attr_reader :board, :players, :display, :current_player
    def initialize(player1, player2)
        @board = Board.new
        @display = Display.new(board)
        @players = {:white => player1.new(board), :black => player2.new(board)}
        @current_player = :white
    end

    def play
        until players.any? { |player| board.checkmate?(player) } do

            begin
                @players[current_player].make_move(board)
            rescue => error
                puts error.message
                sleep 5
            end 

            swap_turn!
        end
    end

    private

    def swap_turn!
        if current_player == :white
            @current_player = :black
        else
            @current_player = :white
        end
    end
end