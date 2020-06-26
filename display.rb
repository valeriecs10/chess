require 'colorize'
require_relative 'cursor'
require_relative 'pieces/null_piece'
require 'byebug'

class Display
    attr_reader :board, :cursor, :notifications

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board) 
        @notifications = {
            "white => checkmate" => false,
            "white => check" => false,
            "black => checkmate" => false,
            "black => check" => false
        }
    end

    def render
        clear_board
        directions
        print_board
        update_notifications
        display_notifications
    end

    private

    def update_notifications
        reset_notifications
        update_notification_status(:white)
        update_notification_status(:black)
    end

    def reset_notifications
        notifications["white => checkmate"] = false
        notifications["white => check"] = false
        notifications["black => checkmate"] = false
        notifications["black => check"] = false
    end

    def update_notification_status(color)
        if board.checkmate?(color)
            notifications["#{color} => checkmate"] = true
        elsif board.in_check?(color)
            notifications["#{color} => check"] = true
        end
    end

    def display_notifications 
        notifications.each { |k, v| puts "#{k}" if v == true }
        nil
    end

    def clear_board
        system("clear")
    end

    def directions
        puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    end

    def print_board
        board.rows.each_with_index do |row, row_i|
            row.each_with_index do |space, space_i|
                if @cursor.cursor_pos == space.pos 
                    print_cursor(space)
                else
                    print_colored_space(space, row_i, space_i)
                end
            end
            puts
        end
    end

    def print_colored_space(space, row_i, space_i)
       if row_i.even? 
            if space_i.even? 
                print space.to_s.on_yellow 
            else
                print space.to_s.on_blue 
            end
        else
            if space_i.even? 
                print space.to_s.on_blue 
            else
                print space.to_s.on_yellow
            end
        end 
    end

    def print_cursor(space)
        @cursor.selected ? (print space.to_s.on_red) : (print space.to_s.on_green)
    end

end
