require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
    include Slideable

    def symbol
        color == :black ? ♛ : ♕
    end

    protected

    def move_dirs
        horizontal_vertical_dirs + diagonal_moves
    end

end