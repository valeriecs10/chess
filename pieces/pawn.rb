require_relative 'piece'
require 'byebug'

class Pawn < Piece
    def symbol

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
        steps = [[(1 * forward_dir) + px, py]]
        steps << [(2 * forward_dir) + px, py] if at_start_row?

        steps.each do |step|
            current = [px + step[0], py + step[1]]
            steps.delete(step) unless @board[current].empty?
        end

        debugger if steps.any? { |step| step == nil } # DELETE AFTER TESTING

        steps
    end

    # Bad logic in side_attacks, reformulate

    def side_attacks
        attacks = [[1 * forward_dir, -1], [1 * forward_dir, 1]]
        # debugger
        attacks.map! { |step| [@pos[0] + step[0], @pos[1] + step[1]] }
            
        attacks.each { |pos| attacks.delete(pos) unless !@board[pos].empty? && @board[pos].color != self.color }   

        attacks
    end

end