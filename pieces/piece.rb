
class Piece
    attr_accessor :pos, :board # board needs to update piece's new pos in move_piece method... safer way to do this? board also needs to update board for temp pieces in dup
    attr_reader :color

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def to_s
        symbol
    end

    def empty?
        return true if self.is_a?(NullPiece)
        false
    end

    def valid_moves
        moves.select { |move| !move_into_check?(move) }
    end

    def pos=(val)
        @pos = val
    end

    def symbol
        #overwritten in subclasses
        raise 'symbol not instantiated'
    end

    def moves
        #overwritten in subclasses
        raise 'moves not instantiated'
    end

    private

    #NEEDS TESTING
    def move_into_check?(end_pos)
        temp = @board.dup
        temp.move_piece!(@pos, end_pos)
        temp.in_check?(@color)
    end

end

