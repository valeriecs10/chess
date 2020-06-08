require_relative 'piece'
require_relative 'slideable'

class Rook < Piece
    include Slideable

    def move_dirs
        horizontal_vertical_dirs
    end
end