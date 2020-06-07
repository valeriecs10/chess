require 'byebug'

module Slideable
    HORIZONTAL_VERTICAL_DIRS = [
        [0, -1],
        [0, 1],
        [-1, 0],
        [1, 0]
    ]

    DIAGONAL_DIRS = [
        [-1, -1],
        [1, 1],
        [-1, 1],
        [1, -1]
    ]

    def horizontal_vertical_dirs
        HORIZONTAL_VERTICAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end
    
    def moves
        all_moves = []
        
        move_dirs.each do |x, y|
            all_moves += grow_unblocked_moves_in_dir(x, y)
        end

        all_moves
    end

    def grow_unblocked_moves_in_dir(x, y)
        dir_moves = []
        current_pos = [@pos[0], @pos[1]]

        loop do
            current_pos = [current_pos[0] + x, current_pos[1] + y]

            break unless @board.valid_pos?(current_pos)

            if @board[current_pos].is_a?(NullPiece)
                dir_moves << current_pos 
            else
                if @board[current_pos].color != self.color
                    dir_moves << current_pos
                    break
                else
                    break
                end
            end
        end
        dir_moves
    end

end

module Stepable
end

class Piece
    include Slideable
    attr_accessor :current_pos # board needs to update piece's new pos in move_piece method... safer way to do this?
    attr_reader :color

    def initialize(color, pos, board)
        @color = color
        @pos = pos
        @board = board
    end

    # FOR TESTING ONLY
    def move_dirs   
        horizontal_vertical_dirs + diagonal_dirs
    end
end

