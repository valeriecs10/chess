require_relative 'piece'
require_relative 'Stepable'

class King < Piece
    include Stepable

    def symbol
        color == :black ? " ♚ ".colorize(:black) : " ♚ "
    end

    protected
    
    def move_diffs
        [
            [-1, -1],
            [-1, 0],
            [-1, 1],
            [0, 1],
            [1, 1],
            [1, 0], 
            [1, -1],
            [0, -1]
        ]
    end
end