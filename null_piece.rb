require_relative 'piece'

class NullPiece < Piece
    # include Singleton

    def initialize(pos, board)
        @pos = pos
        @board = board
    end

end