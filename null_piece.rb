require_relative 'piece'

class NullPiece < Piece
    # include Singleton
    def initialize
        # directions say you need a way to read color and symbol?
        @color = nil
        @symbol = nil
    end

end