
module Stepable
    def moves
        move_diffs.each_with_object([]) do |diff, arr|
            current_pos = [@pos[0] + diff[0], @pos[1] + diff[1]]

            next unless @board.valid_pos?(current_pos)

            if @board[current_pos].is_a?(NullPiece) || @board[current_pos].color != self.color
                arr << current_pos
            end
        end
    end

    private

    def move_diffs
        # Overwritten by subclass
        raise "Move_diffs not instantiated"
    end
    
end