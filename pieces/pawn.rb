require_relative 'piece'
require 'byebug'

class Pawn < Piece
    def symbol
        @color == :black ? ♟︎ : ♙
    end

    def moves
        forward_steps + side_attacks
    end

    private

    def at_start_row?
        start_row = color == :white ? 1 : 6
        @pos[0] == start_row
    end

    def forward_dir
        color == :white ? 1 : -1
    end

    def forward_steps
        px, py = @pos
        moves = []
        # debugger
        current = [px + forward_dir, py]
        
        if @board[current].empty?
            moves << [current[0], current[1]]
            if at_start_row?
                current[0] += forward_dir
                moves << [current[0], current[1]] if @board[current].empty?
            end
        end

        moves
    end

    def side_attacks
        steps = [[1 * forward_dir, -1], [1 * forward_dir, 1]]
        moves = []

        steps.each do |step|
            current = [step[0] + @pos[0], step[1] + @pos[1]]
            moves << current if !@board[current].empty? && @board[current].color != self.color
        end

        moves
    end

end