module Slideable
    HORIZONTAL_VERTICAL_DIRS = [
        [0, -1],
        [0, 1],
        [-1, 0],
        [1, 0]
    ]

    DIAGONAL_DIRS = [
        [-1, -1],
        [1, 1],
        [-1, 1],
        [1, -1]
    ]

    def horizontal_vertical_dirs
        HORIZONTAL_VERTICAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end
    
    def moves
        all_moves = []
        
        move_dirs.each do |dx, dy|
            all_moves += grow_unblocked_moves_in_dir(dx, dy)
        end

        all_moves
    end

    private

    def move_dirs
        # Overwritten by subclass
        raise "Move_dirs not instantiated"
    end

    def grow_unblocked_moves_in_dir(dx, dy)
        dir_moves = []
        current_pos = [@pos[0], @pos[1]]

        loop do
            current_pos = [current_pos[0] + dx, current_pos[1] + dy]

            break unless @board.valid_pos?(current_pos)

            if @board[current_pos].is_a?(NullPiece)
                dir_moves << current_pos 
            else
                if @board[current_pos].color != self.color
                    dir_moves << current_pos
                    break
                else
                    break
                end
            end
        end
        dir_moves
    end

end