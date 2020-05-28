require_relative 'piece'
require_relative 'null_piece'
require 'byebug'

class Board
    attr_reader :grid #REMOVE AFTER TESTING

    def initialize
        @grid = new_board
    end
    
    def new_board
        board = Array.new(8) { Array.new(8) }
        board[0] = row_of_pieces(board[0])
        board[1] = row_of_pieces(board[1])
        board[2] = row_of_null_pieces(board[2])
        board[3] = row_of_null_pieces(board[3])
        board[4] = row_of_null_pieces(board[4])
        board[5] = row_of_null_pieces(board[5])
        board[6] = row_of_pieces(board[6])
        board[7] = row_of_pieces(board[7])
        board
    end

    def [](pos)
        x, y = pos
        @grid[x][y]
    end

    def []=(pos, piece)
        x, y = pos
        @grid[x][y] = piece
    end
    
    def row_of_pieces(row)
        row.map { |space| Piece.new }
    end

    def row_of_null_pieces(row)
        row.map { |space| NullPiece.new }
    end

    def move_piece(start_pos, end_pos)
        raise "No piece at start position" if self[start_pos].is_a?(NullPiece)
        raise "Not a valid move" if !valid_move(start_pos, end_pos)
        self[end_pos] = self[start_pos] 
        self[start_pos] = NullPiece.new
    end

    def valid_move(start_pos, end_pos)
        x1, y1 = start_pos
        x2, y2 = end_pos
        return false if [x1, y1, x2, y2].any? { |i| !i.between?(0, 7) }
        true
    end
end