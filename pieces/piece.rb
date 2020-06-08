
class Piece
    attr_accessor :current_pos # board needs to update piece's new pos in move_piece method... safer way to do this?
    attr_reader :color

    def initialize(color, pos, board)
        @color = color
        @pos = pos
        @board = board
    end

    # FOR TESTING ONLY, REMOVE FROM FINAL
    # def move_dirs   
    #     horizontal_vertical_dirs + diagonal_dirs
    # end
end

