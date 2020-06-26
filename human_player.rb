require_relative 'display'
require_relative 'board'

class HumanPlayer
    attr_reader :board, :display

    def initialize(board)
        @board = board
        @display = Display.new(board)
    end

    def make_move(board)
        start_pos = []
        end_pos = []
        display.render(true)
        
        until end_pos != start_pos do
            start_pos = []
            end_pos = []
            start_pos = select_input
            end_pos = select_input
        end

        board.move_piece(start_pos, end_pos)
    end
    
    private
    
    def select_input
        input = nil
    
        while input.nil?
            input = display.cursor.get_input
            display.render
        end
        
        return input
    end
end