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
        i = 0
        until new_pos.any? { |coord| coord == 7 }
            new_pos = top_pos.map { |coord| coord += i }
            possible_moves << new_pos unless new_pos == @current_pos
            i += 1
        end
        possible_moves
    end

    def up_diagonal_moves
        possible_moves = []
        position = []
        # debugger
        # start at bottom position
        if @current_pos[0] + @current_pos[1] >= 7
            position[0] = 7
            position[1] = (@current_pos[0] + @current_pos[1]) - 7
        else
            position[0] = @current_pos[0] + @current_pos[1]
            position[1] = 0
        end

        count = 0
        until position[0] - count < 0 || position[1] + count > 7
            new_pos = up_diagonal_adjust(position, count)
            possible_moves << new_pos unless new_pos == @current_pos
            count += 1
        end
        possible_moves
    end

    def up_diagonal_adjust(pos, count)
        return [pos[0] - count, pos[1] + count]
    end
end

class Piece
    attr_accessor :current_pos # board needs to update piece's new pos in move_piece method... safer way to do this?

    def initialize(color, pos, board)
        @color = color
        @current_pos = pos
        @board = board
    end

    def move_dirs
        # [horizontal/vertical, diagonal]
        [false, false]
    end
end


module Stepable

end