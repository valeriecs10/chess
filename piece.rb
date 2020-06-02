require 'byebug'

module Slideable

    def moves
        all_moves = []
        # #move_dirs returns an array, el 0 reps horiz/vert and el 1 reps diagonal
        dirs = move_dirs

        if dirs[0] 
            all_moves += horiz_moves 
            all_moves += vert_moves
        end

        if dirs[1]
            all_moves += down_diagonal_moves
            all_moves += up_diagonal_moves
        end

        all_moves
    end

    def horiz_moves
        possible_moves = []
        (0..7).to_a.each do |col|
            possible_moves << [@current_pos[0], col] unless col == @current_pos[1]
        end
        possible_moves
    end
    
    def vert_moves
        possible_moves = []
        (0..7).to_a.each do |row|
            possible_moves << [row, @current_pos[1]] unless row == @current_pos[0]
        end
        possible_moves
    end

    def down_diagonal_moves
        possible_moves = []
        # start pos at top position
        top_pos = [@current_pos[0] - @current_pos[0], @current_pos[1] - @current_pos[0]]
        new_pos = top_pos
        i = 1
        until new_pos.any? { |coord| coord == 7 }
            possible_moves << new_pos unless new_pos == @current_pos
            new_pos = top_pos.map { |coord| coord += i }
            i += 1
        end
        possible_moves
    end

    def up_diagonal_moves
        possible_moves = []
        bottom_pos = []
        # start at bottom position
        if @current_pos[0] + @current_pos[1] >= 7
            bottom_pos[0] = 7
            bottom_pos[1] = (@current_pos[0] + @current_pos[1]) - 7
        else
            bottom_pos[0] = @current_pos[0] + @current_pos[1]
            bottom_pos[1] = 0
        end
        new_pos = bottom_pos
        until new_pos[0] == 0 || new_pos[1] == 7
            debugger
            possible_moves << new_pos unless new_pos == @current_pos
            new_pos[0] -= 1
            new_pos[1] += 1
        end
        possible_moves
    end
end

class Piece
    include Slideable # REMOVE AFTER TESTING

    def initialize(color, pos, board)
        @color = color
        @current_pos = pos
        @board = board
    end

    def move_dirs
        [1,1]
    end
end


module Stepable

end