require_relative 'pieces'
require 'byebug'

class Board
    attr_reader :rows

    def initialize
        @rows = new_board
    end
    
    def new_board
        board = Array.new(8) { Array.new(8) }
        board[0] = row_of_mixed_pieces(board[0], 0, :white)
        board[1] = row_of_pawns(board[1], 1, :white)
        board[2] = row_of_null_pieces(board[2])
        board[3] = row_of_null_pieces(board[3])
        board[4] = row_of_null_pieces(board[4])
        board[5] = row_of_null_pieces(board[5])
        board[6] = row_of_pawns(board[6], 6, :black)
        board[7] = row_of_mixed_pieces(board[7], 7, :black)
        board
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
        raise "No piece at start position" if self[start_pos].is_a?(NullPiece)
        raise "Not a valid move" if !valid_pos?(start_pos) || !piece.moves.include?(end_pos)
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

    end

    def in_check?(color)

    end

    def find_king(color)

    end

    def pieces

    end

    def dup

    end

    def move_piece!(color, start_pos, end_pos)

    end


end