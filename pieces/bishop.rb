require_relative 'piece'
require_relative 'slideable'

class Bishop < Piece
    include Slideable

    def symbol
        color == :black ? ♝ : ♗
    end

    protected

    def move_dirs
        diagonal_dirs
    end

end