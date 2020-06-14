require_relative 'piece'
require_relative 'slideable'

class Rook < Piece
    include Slideable

    def symbol
        color == :black ? " ♜ ".colorize(:black) : " ♜ "
    end

    protected

    def move_dirs
        horizontal_vertical_dirs
    end
end