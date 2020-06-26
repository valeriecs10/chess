require_relative 'pieces'
require 'byebug'

class Board
    attr_reader :rows

    def initialize(fill_board = true)
        @rows = Array.new(8) { Array.new(8) { NullPiece.instance } }
        set_pieces if fill_board
    end
    
    def [](pos)
        x, y = pos
        @rows[x][y]
    end
    
    def []=(pos, val)
        x, y = pos
        @rows[x][y] = val
    end
    
    def move_piece(start_pos, end_pos, color = nil)
        piece = self[start_pos]
        validate_input(start_pos, end_pos)
        
        self[end_pos] = self[start_pos] 
            
        # assign new position to piece that was moved
        self[end_pos].pos = end_pos
            
        self[start_pos] = NullPiece.instance
    end
        
    def valid_pos?(pos)
        return false if pos.any? { |i| !i.between?(0, 7) }
        true
    end
        
    def add_piece(piece, color, pos)
        raise "Not a valid pos" unless valid_pos?(pos)
        self[pos] = piece.new(color, self, pos)
    end
        
    def checkmate?(color)
        return false if !in_check?(color)
        pieces.select { |piece| piece.color == color }.all? do |piece|
            piece.valid_moves.empty?
        end
    end
        
    def in_check?(color)
        king_pos = find_king(color)
        opposing_color = color == :black ? :white : :black
        pieces.each do |piece|
            return true if piece.moves.include?(king_pos)
        end
        false
    end
        
    def find_king(color)
        pieces.each { |piece| return piece.pos if piece.is_a?(King) && 
        piece.color == color }
    end
        
    def pieces
        pieces = []
        @rows.each do |row|
            row.each do |space|
                pieces << space unless space.is_a?(NullPiece)
            end
        end
        pieces
    end
        
    def dup
        temp = Board.new(false)
        temp.rows.each_with_index do |row, row_i|
            row.each_with_index do |space, space_i|
                original = self[[row_i, space_i]]
                unless original.is_a?(NullPiece)
                    temp.add_piece(original.class, original.color, [row_i, space_i])
                end
            end
        end
        temp
    end
        
    def move_piece!(start_pos, end_pos, color = nil)
        piece = self[start_pos]
        raise "No piece at start position" if self[start_pos].is_a?(NullPiece)
        raise "Not a valid move" if !valid_pos?(start_pos) || !piece.moves.include?(end_pos)
        self[end_pos] = self[start_pos] 
            
        # assign new position to piece that was moved
        self[end_pos].pos = end_pos
            
        self[start_pos] = NullPiece.instance
    end
        
    private

    def validate_input(start_pos, end_pos)
        begin
            raise "No piece at start position" if self[start_pos].is_a?(NullPiece)
            raise "Not a valid move" if !valid_pos?(start_pos) || 
            !piece.valid_moves.include?(end_pos)
        rescue
            # report error here and loop again?
        end
    end

    def set_pieces
        @rows[0] = row_of_mixed_pieces(@rows[0], 0, :white)
        @rows[1] = row_of_pawns(@rows[1], 1, :white)
        @rows[6] = row_of_pawns(@rows[6], 6, :black)
        @rows[7] = row_of_mixed_pieces(@rows[7], 7, :black)
    end
    
    def row_of_mixed_pieces(row, row_i, color)
        [
            Rook.new(color, self, [row_i, 0]),
            Knight.new(color, self, [row_i, 1]),
            Bishop.new(color, self, [row_i, 2]),
            Queen.new(color, self, [row_i, 3]),
            King.new(color, self, [row_i, 4]),
            Bishop.new(color, self, [row_i, 5]),
            Knight.new(color, self, [row_i, 6]),
            Rook.new(color, self, [row_i, 7])
        ]
    end
    
    def row_of_pawns(row, row_i, color)
        row.each_with_index.map { |space, col| Pawn.new(color, self, [row_i, col]) }
    end
    
    def row_of_null_pieces(row)
        row.each_with_index.map { |space| NullPiece.instance }
    end

end
