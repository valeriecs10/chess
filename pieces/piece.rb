
class Piece
    attr_accessor :pos # board needs to update piece's new pos in move_piece method... safer way to do this?
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
        
    end

    def pos=(val)
        @pos = val
    end

    def symbol

    end

    private

    def move_into_check?(end_pos)

    end
    
end

